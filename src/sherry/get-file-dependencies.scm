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

(define-module (sherry get-file-dependencies)
  :export (get-file-dependencies/print)
  :use-module ((euphrates define-type9) :select (define-type9))
  :use-module ((euphrates identity) :select (identity))
  :use-module ((euphrates irregex) :select (irregex-match-substring irregex-replace irregex-search sre->irregex))
  :use-module ((euphrates lines-to-string) :select (lines->string))
  :use-module ((euphrates list-maximal-element-or) :select (list-maximal-element-or))
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((euphrates string-split-3) :select (string-split-3))
  :use-module ((euphrates string-strip) :select (string-strip))
  :use-module ((euphrates string-to-lines) :select (string->lines))
  :use-module ((euphrates string-to-words) :select (string->words))
  :use-module ((euphrates stringf) :select (stringf))
  :use-module ((euphrates tilda-a) :select (~a))
  :use-module ((euphrates words-to-string) :select (words->string))
  :use-module ((sherry yearsrange) :select (make-yearsrange yearsrange-end yearsrange-start yearsrange?))
  )

(define (get-file-dependencies/print <filepath>)
  (display "DUNNO") (newline))
