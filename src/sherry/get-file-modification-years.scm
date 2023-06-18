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

(define-module (sherry get-file-modification-years)
  :export (get-file-modification-years get-file-modification-years/print)
  :use-module ((euphrates identity) :select (identity))
  :use-module ((euphrates list-deduplicate) :select (list-deduplicate/reverse))
  :use-module ((euphrates path-get-basename) :select (path-get-basename))
  :use-module ((euphrates path-get-dirname) :select (path-get-dirname))
  :use-module ((euphrates run-syncproc-re) :select (run-syncproc/re))
  :use-module ((euphrates string-to-lines) :select (string->lines))
  )


(define (get-file-modification-years filename)
  (define years/d/s
    (string->lines
     (run-syncproc/re
      "git" "-C" (path-get-dirname filename)
      "log" "--format=%ad" "--date=format:%Y" "--follow" "--"
      (path-get-basename filename))))

  (list-deduplicate/reverse
   (filter
    identity
    (map string->number years/d/s))))

(define (get-file-modification-years/print filename)
  (define years (get-file-modification-years filename))
  (for-each
   (lambda (year)
     (display year) (newline))
   years))
