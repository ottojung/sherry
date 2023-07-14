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

(define-module (sherry r7rsdecl-get-exports)
  :export (r7rsdecl-get-exports)
  :use-module ((sherry parse-r7rsdecl) :select (parse-r7rsdecl))
  :use-module ((sherry r7rsdecl) :select (r7rsdecl-exports))
  )

(define (r7rsdecl-get-exports decl/sexp)
  (define decl (parse-r7rsdecl decl/sexp))
  (r7rsdecl-exports decl))