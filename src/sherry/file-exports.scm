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

(define-module (sherry file-exports)
  :export (file-exports)
  :use-module ((euphrates properties) :select (define-property define-provider))
  :use-module ((sherry file-first-expression) :select (file-first-expression))
  :use-module ((sherry file-source-type) :select (file-source-type))
  :use-module ((sherry guile-decl-get-exports) :select (guile-decl-get-exports))
  :use-module ((sherry is-guile-decl-huh) :select (is-guile-decl?))
  :use-module ((sherry is-r7rsdecl-decl-huh) :select (is-r7rsdecl-decl?))
  :use-module ((sherry r7rsdecl-get-exports) :select (r7rsdecl-get-exports))
  )

(define-property file-exports)

(define-provider p
  :targets (file-exports)
  :sources ()
  (lambda (this)
    (define type (file-source-type this))
    (define decl/sexp (file-first-expression this))
    (cond
     ((is-guile-decl? decl/sexp)
      (guile-decl-get-exports decl/sexp))
     ((is-r7rsdecl-decl? decl/sexp)
      (r7rsdecl-get-exports decl/sexp))
     (else
      (list) ;; NOTE: maybe throw an error instead?
      ))))
