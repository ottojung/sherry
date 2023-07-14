;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry parse-r7rsdecl)
  :export (parse-r7rsdecl)
  :use-module ((euphrates compose-under) :select (compose-under))
  :use-module ((euphrates list-drop-n) :select (list-drop-n))
  :use-module ((euphrates negate) :select (negate))
  :use-module ((sherry is-r7rsdecl-export-huh) :select (is-r7rsdecl-export?))
  :use-module ((sherry is-r7rsdecl-import-huh) :select (is-r7rsdecl-import?))
  :use-module ((sherry r7rsdecl) :select (make-r7rsdecl))
  )

(define (parse-r7rsdecl x)
  (make-r7rsdecl
   (list-ref x 0)
   (list-ref x 1)
   (apply
    append
    (map
     cdr
     (filter is-r7rsdecl-export? x)))
   (map
    cdr
    (filter is-r7rsdecl-import? x))
   (filter
    (negate
     (compose-under
      or is-r7rsdecl-export? is-r7rsdecl-import?))
    (list-drop-n 2 x))
   ))
