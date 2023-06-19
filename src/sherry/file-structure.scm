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


(define-module (sherry file-structure)
  :export (file-structure)
  :use-module ((euphrates properties) :select (define-property))
  :use-module ((sherry licensedfile) :select (parse-licensedfile))
  )

(define-property
  file-structure
  :initialize
  (lambda (this skip!)
    (parse-licensedfile this))
  set-file-license!)
