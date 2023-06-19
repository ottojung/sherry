;;;; Copyright (C) 2023  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry install-guile-program)
  :export (install-guile-program)
  :use-module ((euphrates append-posix-path) :select (append-posix-path))
  :use-module ((euphrates fn-pair) :select (fn-pair))
  :use-module ((euphrates make-directories) :select (make-directories))
  :use-module ((euphrates remove-common-prefix) :select (remove-common-prefix))
  :use-module ((euphrates run-syncproc) :select (run-syncproc))
  )


(define (install-guile-program binary-names+filepaths-of-main project-name dirpath-of-src install-prefix-share install-prefix-bin)
  (define share-target (append-posix-path install-prefix-share project-name))

  (make-directories install-prefix-share)
  (make-directories install-prefix-bin)
  (run-syncproc "cp" "-f" "-L" "-T" "-r" "--" dirpath-of-src share-target)

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
