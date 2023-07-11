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

(define-module (sherry guile-module-definition-exports)
  :export (guile-module-definition-exports)
  :use-module ((euphrates list-drop-n) :select (list-drop-n))
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((sherry is-guile-module-definition-huh) :select (is-guile-module-definition?))
  )

(define (guile-module-definition-exports guile-module)
  (define (maybe-unpack-pair p)
    (if (pair? p)
        (cdr p)
        p))

  (unless (is-guile-module-definition? guile-module)
    (raisu 'not-a-guile-module-definiton guile-module))

  (map
   maybe-unpack-pair
   (apply
    append
    (let loop ((first (list-ref guile-module 0))
               (second (list-ref guile-module 1))
               (rest (list-drop-n 2 guile-module)))
      (define (next)
        (if (null? rest) '()
            (loop second (car rest) (cdr rest))))

      (if (memq first '(:export #:export
                        :export-syntax #:export-syntax
                        :re-export #:re-export
                        :re-export-syntax #:re-export-syntax
                        :re-export-and-replace #:re-export-and-replace
                        :re-export-replacements #:re-export-replacements
                        :replace #:replace
                        ))
          (cons second (next))
          (next))))))
