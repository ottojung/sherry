;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-property license-up-to-date?/all-years)
(define-property license-not-included-years/all-years)

(define-property license-up-to-date?/current-year)
(define-property license-not-included-years/current-year)


(define (calculate-not-included --all-years this)
  (define years
    (license-years this))

  (define filepath
    (license-filepath this))

  (define license-exists?
    (file-license-exists? filepath))

  (define modification-years/0
    (file-modification-years filepath))

  (define current-year
    (get-current-year))

  (define modification-years
    (if --all-years
        modification-years/0
        (filter (lambda (year) (equal? year current-year)) modification-years/0)))

  (define not-included-years
    (filter (lambda (y) (not (year-in-years? y years)))
            modification-years))

  (values (and license-exists? (null? not-included-years))
          not-included-years))


(define-provider p1
  :targets (license-up-to-date?/all-years license-not-included-years/all-years)
  :sources (license-years license-filepath file-modification-years)
  (lambda (this)
    (calculate-not-included #t this)))


(define-provider p2
  :targets (license-up-to-date?/current-year license-not-included-years/current-year)
  :sources (license-years license-filepath file-modification-years)
  (lambda (this)
    (calculate-not-included #f this)))
