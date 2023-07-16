;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (create-file-by-name/print <export-name>)
  (display (create-file-by-name <export-name>))
  (newline))

(define (create-file-by-name <export-name>)
  (define file-name (export-name->file-name <export-name>))
  (define main-filepath
    (string-append file-name ".scm"))
  (define lib-filepath
    (string-append file-name ".sld"))

  (write-string-file main-filepath "")

  (let ((--if-exists #f)
        (--all-years #f)
        (filepath main-filepath))
    (update-file-license/overwrite --if-exists --all-years filepath))

  (define current-text
    (read-string-file main-filepath))

  (define random-neighbour
    (list-find-first
     file-module-declaration
     #f (file-neighbours main-filepath)))

  (define type
    (file-source-type random-neighbour))

  (define neighbours-module
    (file-module-declaration random-neighbour))

  (define inferred-module
    (appcomp neighbours-module
             (module-declaration-replace-name
              (string->symbol file-name))
             (module-declaration-replace-exports
              (list (string->symbol <export-name>)))))

  (call-with-output-file
      main-filepath
    (lambda (p)
      (display current-text p)
      (newline p)
      (cond
       ((equal? type 'guile)
        (pretty-print inferred-module p)
        (newline p))
       (else 'pass))
      (write `(define (,(string->symbol <export-name>) TODO) TODO) p)
      (newline p)))

  (cond
   ((equal? type 'guile) 'pass)
   ((equal? type 'r7rs/library)
    (call-with-output-file
        lib-filepath
      (lambda (p)
        (pretty-print inferred-module p))))

   ((or (equal? type 'r7rs/program)
        (equal? type 'r7rs/source))
    (raisu 'unexpected-type-of-neighbours-module type))

   (else
    (raisu 'unrecognized-type-of-neighbours-module type)))

  main-filepath)
