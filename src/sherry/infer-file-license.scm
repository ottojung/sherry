;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (infer-from-neighbours filepath)
  (define _1
    (log-info "Trying to infer the license from the neighbours of ~s." filepath))
  (define neighbours
    (file-neighbours filepath))
  (define found
    (list-map-first file-license #f neighbours))
  (define years
    (get-file-modification-years filepath))

  (and found
       (make-license
        filepath
        years
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
