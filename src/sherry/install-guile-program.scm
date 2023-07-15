;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry install-guile-program)
  :export (install-guile-program)
  :use-module ((euphrates append-posix-path) :select (append-posix-path))
  :use-module ((euphrates file-or-directory-exists-q) :select (file-or-directory-exists?))
  :use-module ((euphrates fn-pair) :select (fn-pair))
  :use-module ((euphrates get-current-directory) :select (get-current-directory))
  :use-module ((euphrates make-directories) :select (make-directories))
  :use-module ((euphrates path-get-basename) :select (path-get-basename))
  :use-module ((euphrates path-normalize) :select (path-normalize))
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((euphrates remove-common-prefix) :select (remove-common-prefix))
  :use-module ((euphrates run-syncproc) :select (run-syncproc))
  :use-module ((euphrates system-environment) :select (system-environment-get))
  )

(define (infer-main-binary-name dirpath-of-src project-name)
  project-name)

(define (infer-project-name dirpath-of-src)
  (define pwd (get-current-directory))
  (cond
   ((string-prefix? pwd (path-normalize dirpath-of-src))
    (path-get-basename pwd))
   (else
    (raisu 'could-not-infer-project-name "Could not infer the project name"))))

(define (infer-binary-names-and-filepaths-of-main dirpath-of-src project-name)
  (define (try path)
    (and (file-or-directory-exists? path) path))

  (define (try-name filename)
    (try (append-posix-path dirpath-of-src project-name filename)))

  (define (get-name filename)
    (append-posix-path dirpath-of-src project-name filename))

  (list (cons project-name
              (or (try-name "main.sld")
                  (try-name "main.scm")
                  (try-name "main.rkt")
                  (try-name (string-append project-name ".sld"))
                  (try-name (string-append project-name ".scm"))
                  (try-name (string-append project-name ".rkt"))))))

(define (infer-prefix)
  (or (system-environment-get "PREFIX")
      (let ()
        (define HOME (system-environment-get "HOME"))
        (and HOME (append-posix-path HOME ".local")))
      "/usr/local"))

(define (infer-prefix-share)
  (append-posix-path (infer-prefix) "share"))

(define (infer-prefix-bin)
  (append-posix-path (infer-prefix) "bin"))

(define (install-guile-program binary-names+filepaths-of-main/0 project-name/0 dirpath-of-src/0 install-prefix-share/0 install-prefix-bin/0)
  (define dirpath-of-src
    (or dirpath-of-src/0 (append-posix-path (get-current-directory) "src")))

  (define project-name
    (or project-name/0 (infer-project-name dirpath-of-src)))

  (define binary-names+filepaths-of-main
    (if (null? binary-names+filepaths-of-main/0)
        (infer-binary-names-and-filepaths-of-main dirpath-of-src project-name)
        binary-names+filepaths-of-main/0))

  (define install-prefix-share
    (or install-prefix-share/0
        (infer-prefix-share)))

  (define install-prefix-bin
    (or install-prefix-bin/0
        (infer-prefix-bin)))

  (define share-target (append-posix-path install-prefix-share project-name))

  (make-directories install-prefix-share)
  (make-directories install-prefix-bin)

  (unless (= 0 (run-syncproc "cp" "-f" "-p" "-L" "-T" "-r" "--" dirpath-of-src share-target))
    (raisu 'copy-failed "Failing the process because copying the files failed"))

  (for-each
   (fn-pair
    (binary-name filepath-of-main)
    (define relative-filepath-of-main (remove-common-prefix filepath-of-main dirpath-of-src))
    (define bin-target (append-posix-path install-prefix-bin binary-name))
    (define main-target (append-posix-path share-target relative-filepath-of-main))

    (call-with-output-file
        bin-target
      (lambda (p)
        (display "#! /bin/sh" p) (newline p)
        (display "exec guile --r7rs -L " p)
        (write share-target p)
        (display " -s " p)
        (write main-target p)
        (display " " p)
        (write "$@" p)
        (newline p)))

    (run-syncproc "chmod" "+x" "--" bin-target))
   binary-names+filepaths-of-main))
