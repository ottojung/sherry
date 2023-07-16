;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry module-declaration-replace-name)
  :export (module-declaration-replace-name)
  :use-module ((euphrates list-replace-last) :select (list-replace-last))
  :use-module ((euphrates raisu) :select (raisu))
  )

(define (module-declaration-replace-name new-name decl)
  (define first (car decl))
  (cond
   ((or (equal? 'define-module first) ;; guile
        (equal? 'define-library first) ;; r7rs
        )
    (let ()
      (define current-full-name (cadr decl))
      (define new-full-name (list-replace-last new-name current-full-name))
      (cons first (cons new-full-name (cddr decl)))))
   (else
    (raisu 'unrecognized-declaration-type first))))
