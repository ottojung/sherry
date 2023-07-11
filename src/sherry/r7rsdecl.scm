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

(define-module (sherry r7rsdecl)
  :export (make-r7rsdecl r7rsdecl-keyword r7rsdecl-signature r7rsdecl-exports r7rsdecl-imports r7rsdecl-other)
  :use-module ((euphrates define-type9) :select (define-type9))
  )

(define-type9 <r7rsdecl>
  (make-r7rsdecl keyword signature exports imports other) r7rsdecl?
  (keyword r7rsdecl-keyword)
  (signature r7rsdecl-signature)
  (exports r7rsdecl-exports)
  (imports r7rsdecl-imports)
  (other r7rsdecl-other)
  ;; there may be other fields
  )
