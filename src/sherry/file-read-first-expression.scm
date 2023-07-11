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

(define-module (sherry file-read-first-expression)
  :export (file-read-first-expression)
  :use-module ((euphrates catch-any) :select (catch-any))
  )

(define (file-read-first-expression <filepath>)
  (call-with-input-file
      <filepath>
    (lambda (p)
      (define first
        (catch-any
         (lambda _ (read p))
         (lambda _ #f)))
      first)))