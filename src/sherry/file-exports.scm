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

(define-module (sherry file-exports)
  :export (file-exports)
  :use-module ((euphrates properties) :select (define-property define-provider))
  :use-module ((sherry file-source-type) :select (file-source-type))
  )

(define-property file-exports)

(define-provider p
  :targets (file-exports)
  :sources ()
  (lambda (this)
    (define type (file-source-type this))
    TODO))