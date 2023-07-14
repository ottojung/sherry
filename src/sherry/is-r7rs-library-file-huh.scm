;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry is-r7rs-library-file-huh)
  :export (is-r7rs-library-file?)
  :use-module ((euphrates path-extension) :select (path-extension))
  :use-module ((sherry file-first-expression) :select (file-first-expression))
  )

(define (is-r7rs-library-file? <filepath>)
  (or (equal? ".sld" (path-extension <filepath>))
      (let ((first (file-first-expression <filepath>)))
        (and (pair? first)
             (list? first)
             (equal? 'define-library (car first))))))
