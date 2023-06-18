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
  :export (infer-file-license infer-file-license/print)
  :use-module ((euphrates compose-under-seq) :select (compose-under-seq))
  :use-module ((euphrates directory-files) :select (directory-files))
  :use-module ((euphrates list-map-first) :select (list-map-first))
  :use-module ((euphrates negate) :select (negate))
  :use-module ((euphrates path-get-dirname) :select (path-get-dirname))
  :use-module ((euphrates read-lines) :select (read/lines))
  :use-module ((euphrates string-null-or-whitespace-p) :select (string-null-or-whitespace?))
  :use-module ((sherry get-current-year) :select (get-current-year))
  :use-module ((sherry license) :select (display-license license-author license-text make-license))
  :use-module ((sherry licensedfile) :select (licensedfile-license parse-licensedfile parse-licensedfile-lines))
  :use-module ((sherry log) :select (log-error log-info))
  )


(define (infer-from-neighbours filepath)
  (define _1
    (log-info "Trying to infer the license from the neighbours of ~s." filepath))
  (define neighbours
    (map car (directory-files (path-get-dirname filepath))))
  (define found
    (list-map-first
     (compose-under-seq and parse-licensedfile licensedfile-license)
     #f neighbours))
  (and found
       (make-license
        (list (get-current-year))
        (license-author found)
        (license-text found))))


(define (infer-file-license filepath)
  (define lines (read/lines filepath))
  (define non-empty (filter (negate string-null-or-whitespace?) lines))
  (if (null? non-empty)
      (let ()
        (log-info "The file ~s appears empty." filepath)
        (infer-from-neighbours filepath))
      (let ()
        (define parsed (parse-licensedfile-lines lines))
        (or (licensedfile-license parsed)
            (let ()
              (log-info "The file ~s appears to not have an existing license." filepath)
              (infer-from-neighbours filepath))))))


(define (infer-file-license/print filepath)
  (define inferred (infer-file-license filepath))
  (if inferred
      (display-license inferred)
      (log-error "Could not infer the license.")))