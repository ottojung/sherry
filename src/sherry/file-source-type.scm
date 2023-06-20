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

(define-module (sherry file-source-type)
  :export (file-source-type)
  :use-module ((euphrates properties) :select (define-property))
  :use-module ((sherry is-guile-file-huh) :select (is-guile-file?))
  :use-module ((sherry is-r7rs-library-file-huh) :select (is-r7rs-library-file?))
  :use-module ((sherry is-r7rs-program-file-huh) :select (is-r7rs-program-file?))
  :use-module ((sherry is-r7rs-source-file-huh) :select (is-r7rs-source-file?))
  )

(define-property
  file-source-type
  :initialize
  (lambda (this skip!)
    (cond
     ((is-guile-file? this) 'guile)
     ((is-r7rs-library-file? this) 'r7rs/library)
     ((is-r7rs-source-file? this) 'r7rs/source)
     ((is-r7rs-program-file? this) 'r7rs/program)
     (else 'unknown)))
  set-file-source-type!)
