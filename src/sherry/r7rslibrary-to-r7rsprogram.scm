;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (r7rslibrary->r7rsprogram filepath)
  (define source-path (path-replace-extension filepath ".scm"))
  (define lib-path (path-replace-extension filepath ".sld"))
  (define decl (or (file-module-declaration source-path)
                   (file-module-declaration lib-path)))

  (define (reducer tuple)
    (and (pair? tuple)
         (or (equal? 'import (car tuple))
             (and (equal? 'cond-expand (car tuple))
                  (list-and-map reducer (cdr tuple))
                  (cdr tuple)))))

  (define reduced
    (filter reducer decl))

  (define current-text
    (read-string-file source-path))

  (unless (null? reduced)
    (call-with-output-file
        source-path
      (lambda (p)
        (unless (null? reduced)
          (newline p))
        (pretty-print
         `(cond-expand
           (guile)
           ((not guile) ,@reduced))
         p)
        (display current-text p))))

  )
