;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry module-declaration-replace-name)
  :export (module-declaration-replace-name)
  :use-module ((euphrates irregex) :select (irregex-replace/all))
  :use-module ((euphrates list-last) :select (list-last))
  :use-module ((euphrates list-replace-last) :select (list-replace-last))
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((euphrates tilda-a) :select (~a))
  )

(define (replace-all-strings current-name new-name decl)
  (define current-name/s (~a current-name))
  (define new-name/s (~a new-name))

  (let loop ((decl decl))
    (cond
     ((string? decl)
      (irregex-replace/all (list 'seq current-name/s) decl new-name/s))
     ((pair? decl)
      (cons (loop (car decl)) (loop (cdr decl))))
     (else decl))))

(define (module-declaration-replace-name new-name decl)
  (define first (car decl))
  (cond
   ((or (equal? 'define-module first) ;; guile
        (equal? 'define-library first) ;; r7rs
        )
    (let ()
      (define current-full-name (cadr decl))
      (define current-name (list-last current-full-name))
      (define new-full-name (list-replace-last new-name current-full-name))
      (replace-all-strings
       current-name new-name
       (cons first (cons new-full-name (cddr decl))))))
   (else
    (raisu 'unrecognized-declaration-type first))))
