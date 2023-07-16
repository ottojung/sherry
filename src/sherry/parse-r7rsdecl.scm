;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
