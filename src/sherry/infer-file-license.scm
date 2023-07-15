;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry infer-file-license)
  :export (infer-file-license infer-file-license/print)
  :use-module ((euphrates directory-files) :select (directory-files))
  :use-module ((euphrates list-and-map) :select (list-and-map))
  :use-module ((euphrates list-map-first) :select (list-map-first))
  :use-module ((euphrates path-get-dirname) :select (path-get-dirname))
  :use-module ((euphrates string-null-or-whitespace-p) :select (string-null-or-whitespace?))
  :use-module ((sherry file-lines) :select (file-lines))
  :use-module ((sherry get-file-modification-years) :select (get-file-modification-years))
  :use-module ((sherry license) :select (display-license license-author license-text make-license))
  :use-module ((sherry licensedfile) :select (file-license))
  :use-module ((sherry log) :select (log-error log-info))
  )


(define (infer-from-neighbours filepath)
  (define _1
    (log-info "Trying to infer the license from the neighbours of ~s." filepath))
  (define neighbours
    (map car (directory-files (path-get-dirname filepath))))
  (define found
    (list-map-first file-license #f neighbours))

  (and found
       (make-license
        filepath
        (get-file-modification-years filepath)
        (license-author found)
        (license-text found))))


(define (infer-file-license filepath)
  (define lines (file-lines filepath))

  (if (list-and-map string-null-or-whitespace? lines)
      (let ()
        (log-info "The file ~s appears empty." filepath)
        (infer-from-neighbours filepath))
      (or (file-license filepath)
          (let ()
            (log-info "The file ~s appears to not have an existing license." filepath)
            (infer-from-neighbours filepath)))))


(define (infer-file-license/print filepath)
  (define inferred (infer-file-license filepath))

  (if inferred
      (display-license inferred)
      (log-error "Could not infer the license.")))
