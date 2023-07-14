;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry year-in-years-huh)
  :export (year-in-years?)
  :use-module ((euphrates list-find-first) :select (list-find-first))
  :use-module ((sherry yearsrange) :select (yearsrange-end yearsrange-start yearsrange?))
  )

(define (year-in-years? year years)
  (define (included-in? x)
    (or (equal? year x)
        (and (yearsrange? x)
             (>= year (yearsrange-start x))
             (<= year (yearsrange-end x)))))

  (list-find-first included-in? #f years))
