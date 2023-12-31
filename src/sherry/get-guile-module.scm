;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (get-guile-module decl/sexp)
  (if (is-guile-module-definition? decl/sexp)
      decl/sexp
      (and (pair? decl/sexp)
           (equal? 'cond-expand (car decl/sexp))
           (list? (cdr decl/sexp))
           (list-and-map list? (cdr decl/sexp))
           (let* ((alts (cdr decl/sexp))
                  (guiles
                   (or
                    (assq-or 'guile alts)
                    (assq-or 'guile2 alts)
                    (assq-or 'guile3 alts))))
             (and guiles
                  (pair? guiles)
                  (list-find-first
                   is-guile-module-definition?
                   #f guiles))))))
