;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry guile-decl-get-exports)
  :export (guile-decl-get-exports)
  :use-module ((sherry get-guile-module) :select (get-guile-module))
  :use-module ((sherry guile-module-definition-exports) :select (guile-module-definition-exports))
  )

(define (guile-decl-get-exports decl/sexp)
  (define module (get-guile-module decl/sexp))
  (if module
      (guile-module-definition-exports module)
      '()))
