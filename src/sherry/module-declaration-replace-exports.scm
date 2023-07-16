;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (module-declaration-replace-exports new-exports decl)
  (define first (car decl))
  (cond
   ((equal? 'define-module first) ;; guile
    (let loop ((current (car decl))
               (next (cdr decl)))
      (if (null? next)
          (list current)
          (let ((follow (car next)))
            (if (or (equal? current ':export)
                    (equal? current '#:export))
                (cons current (cons new-exports (loop (car (cdr next)) (cdr (cdr next)))))
                (cons current (loop follow (cdr next))))))))

   ((equal? 'define-library first) ;; r7rs
    (map
     (lambda (tuple)
       (define type (car tuple))
       (if (equal? 'export type)
           (cons 'export new-exports)
           tuple))
     decl))
   (else
    (raisu 'unrecognized-declaration-type first))))
