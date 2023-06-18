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


(define-module (sherry infer-file-license)
  :export (infer-file-license)
  :use-module ((euphrates negate) :select (negate))
  :use-module ((euphrates read-lines) :select (read/lines))
  :use-module ((euphrates string-null-or-whitespace-p) :select (string-null-or-whitespace?))
  :use-module ((sherry licensedfile) :select (licensedfile-license parse-licensedfile))
  :use-module ((sherry log) :select (log-info))
  )


(define (infer-from-neighbours filepath)
  (log-info "Trying to infer the license from the neighbours of ~s." filepath)
  0)


(define (infer-file-license filepath)
  (define lines (read/lines filepath))
  (define non-empty (filter (negate string-null-or-whitespace?) lines))
  (if (null? non-empty)
      (let ()
        (log-info "The file ~s appears empty." filepath)
        (infer-from-neighbours filepath))
      (let ()
        (define parsed (parse-licensedfile lines))
        (or (licensedfile-license parsed)
            (let ()
              (log-info "The file ~s appears to not have an existing license." filepath)
              (infer-from-neighbours filepath))))))
