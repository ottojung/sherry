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
    (catchu-case
     (update-file-license/overwrite --if-exists --all-years filepath)
     (('cannot-infer-the-license . args)
      (log-info "Could not infer file license."))))

  (define current-text
    (read-string-file main-filepath))

  (define neighbours-with-declarations
    (filter
     file-module-declaration
     (file-neighbours main-filepath)))

  (log-info "Found ~s neighbours with module declarations." neighbours-with-declarations)

  (define (rank-type t)
    (cond
     ((equal? 'r7rs/library t) 3)
     ((equal? 'r7rs/source t) 2)
     ((equal? 'guile t) 1)
     ((equal? 'r7rs/program t) 0)
     (else -1)))

  (define best-neighbour
    (list-maximal-element-or
     #f (lambda (a b)
          (define a-lic (if (file-license-exists? a) 1 0))
          (define b-lic (if (file-license-exists? b) 1 0))
          (define a-type (rank-type (file-source-type a)))
          (define b-type (rank-type (file-source-type b)))
          (cond
           ((> a-lic b-lic) #t)
           ((< a-lic b-lic) #f)
           (else (> a-type b-type))))
     neighbours-with-declarations))

  (log-info "Found a neighbour ~s with a module declaration." best-neighbour)

  (define type
    (file-source-type best-neighbour))

  (log-info "Its type is ~s." type)

  (define neighbours-module
    (file-module-declaration best-neighbour))

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
