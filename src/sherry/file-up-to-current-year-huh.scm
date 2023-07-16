;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-property file-license-up-to-current-year?)

(define-provider p
  :targets (file-license-up-to-current-year?)
  :sources ()
  (lambda (this)
    (define years (file-modification-years this))
    (define current-year (get-current-year))
    (year-in-years? current-year years)))
