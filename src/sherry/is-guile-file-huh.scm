;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry is-guile-file-huh)
  :export (is-guile-file?)
  :use-module ((sherry file-first-expression) :select (file-first-expression))
  :use-module ((sherry is-guile-decl-huh) :select (is-guile-decl?))
  )

(define (is-guile-file? <filepath>)
  (define first (file-first-expression <filepath>))
  (is-guile-decl? first))
