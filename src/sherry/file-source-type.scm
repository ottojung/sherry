;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-property file-source-type)

(define-provider p
  :targets (file-source-type)
  :sources ()
  (lambda (this)
    (cond
     ((is-guile-file? this) 'guile)
     ((is-r7rs-library-file? this) 'r7rs/library)
     ((is-r7rs-source-file? this) 'r7rs/source)
     ((is-r7rs-program-file? this) 'r7rs/program)
     (else 'unknown))))
