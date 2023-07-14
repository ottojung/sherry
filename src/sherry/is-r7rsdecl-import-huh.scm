;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry is-r7rsdecl-import-huh)
  :export (is-r7rsdecl-import?)
  :use-module ((euphrates list-and-map) :select (list-and-map))
  :use-module ((euphrates list-singleton-q) :select (list-singleton?))
  )

(define (is-r7rsdecl-import? p)
  (and (pair? p)
       (or (equal? (car p) 'import)
           (and (equal? (car p) 'cond-expand)
                (list-and-map
                 (lambda (clause)
                   (define bodies (cdr clause))
                   (and (pair? bodies)
                        (list-singleton? bodies)
                        (equal? (import (car bodies)))))
                 (cdr p))))))
