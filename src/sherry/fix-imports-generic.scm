;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (fix-imports/generic --import-everything <filepath>)
  (define decl/sexp (file-read-first-expression <filepath>))
  (cond
   ((equal? '%run decl/sexp)
    (czempak-main --import-everything <filepath>))
   ((is-guile-decl? decl/sexp)
    (guile-main --import-everything <filepath>))
   (else
    (r7rs-main --import-everything <filepath> decl/sexp))))
