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

(define-module (sherry is-r7rs-source-file-huh)
  :export (is-r7rs-source-file?)
  :use-module ((euphrates file-or-directory-exists-q) :select (file-or-directory-exists?))
  :use-module ((euphrates path-replace-extension) :select (path-replace-extension))
  )

(define (is-r7rs-source-file? <filepath>)
  (define sld-fullname
    (path-replace-extension <filepath> ".sld"))

  (file-or-directory-exists? sld-fullname))
