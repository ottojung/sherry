;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-property file-module-declaration)

(define-provider p
  :targets (file-module-declaration)
  :sources (file-source-type)
  (lambda (this)
    (define type (file-source-type this))
    (cond
     ((equal? type 'unknown) #f)
     ((equal? type 'guile) (file-first-expression this))
     ((equal? type 'r7rs/library) (file-first-expression this))
     ((equal? type 'r7rs/source) #f)
     ((equal? type 'r7rs/program) #f)
     (else (raisu 'unrecognized-source-type type)))))
