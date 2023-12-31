;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(parameterize ((current-program-path/p "my-fix-imports"))
  (with-cli
   (MAIN
    MAIN : --help
    /      initialize-stdlib-exports <root> <files...>*
    /      OPT* DELIM? <filepath>
    OPT  : --import-everything
    DELIM : --
    )

   (when --help
     (define-cli:show-help)
     (exit 0))

   (when initialize-stdlib-exports
     (do-initialize-stdlib-exports <root> (or <files...>* '()))
     (exit 0))

   (let ((decl/sexp (file-read-first-expression <filepath>)))
     (cond
      ((equal? '%run decl/sexp)
       (czempak-main --import-everything <filepath>))
      ((is-guile-decl? decl/sexp)
       (guile-main --import-everything <filepath>))
      (else
       (r7rs-main --import-everything <filepath> decl/sexp))))))
