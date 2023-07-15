;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry license)
  :export (make-license license-author license-years license-text license-prefix license-filepath display-license parse-license-from-lines)
  :use-module ((euphrates define-type9) :select (define-type9))
  :use-module ((euphrates identity) :select (identity))
  :use-module ((euphrates irregex) :select (irregex-match-substring irregex-replace irregex-search sre->irregex))
  :use-module ((euphrates lines-to-string) :select (lines->string))
  :use-module ((euphrates list-maximal-element-or-proj) :select (list-maximal-element-or/proj))
  :use-module ((euphrates properties) :select (define-property define-provider set-property!))
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

(define-property license-years)
(define-property license-author)
(define-property license-text)
(define-property license-prefix) ;; the comment string
(define-property license-filepath) ;; the original file. May not be present? I am not sure.

(define-type9 <license> (license-constructor) license?)

(define (make-license filepath years author text)
  (define license (license-constructor))
  (set-property! (license-years license) years)
  (set-property! (license-author license) author)
  (set-property! (license-text license) text)
  (set-property! (license-filepath license) filepath)
  license)

(define parse-header-line
  (let ((r (sre->irregex
            '(seq bos
                  (+ ";")
                  (* whitespace)
                  (w/nocase "Copyright")
                  (* whitespace)
                  (w/nocase "(C)")))))
    (lambda (header-line)
      (define no-copyright (irregex-replace r header-line ""))
      (define words (string->words (string-strip no-copyright)))
      (let loop ((rest words)
                 (years '()))
        (if (null? rest)
            (raisu 'bad-license-header
                   (stringf "No author found here ~s" header-line))
            (let ()
              (define first (car rest))
              (define striped (string-strip first ","))
              (define maybenumber (string->number striped))
              (define-values (range-start/s dash range-end/s)
                (string-split-3 "-" striped))
              (define range-start (string->number range-start/s))
              (define range-end (string->number range-end/s))
              (cond
               (maybenumber
                (loop (cdr rest)
                      (cons maybenumber years)))
               ((and dash range-start range-end)
                (loop (cdr rest)
                      (cons (make-yearsrange range-start range-end) years)))
               ((string-null? striped)
                (loop (cdr rest) years))
               (else (values years (words->string rest))))))))))


(define (parse-license-from-lines filepath license-lines)
  (if (null? license-lines) #f
      (let ()
        (define header-line (car license-lines))
        (define text (lines->string (cdr license-lines)))
        (define-values (years author) (parse-header-line header-line))
        (make-license filepath years author text))))


(define-provider prefix-getter
  :targets (license-prefix)
  :sources (license-text)
  (let ((pre (sre->irregex '(seq bos (+ ";") (* (or " " "\t"))))))
    (lambda (this)
      (define lines
        (string->lines (license-text this)))
      (define matches
        (filter
         identity
         (map
          (lambda (line)
            (irregex-search pre line))
          lines)))

      (when (null? matches)
        (raisu 'unexpected-license-text this))

      (define prefixes
        (map irregex-match-substring matches))

      (list-maximal-element-or/proj
       #f string-length > prefixes))))


(define (year->string year)
  (cond
   ((yearsrange? year)
    (string-append (~a (yearsrange-start year))
                   "-"
                   (~a (yearsrange-end year))))
   (else
    (~a year))))


(define display-license
  (case-lambda
   ((license) (display-license license (current-output-port)))
   ((license port)
    (parameterize ((current-output-port port))
      (define pre (license-prefix license))
      (define years
        (string-join
         (map year->string (license-years license))
         ", "))

      (display pre)
      (display
       (words->string
        (list "Copyright (C)" years)))
      (display "  ")
      (display (license-author license))
      (newline)
      (display (license-text license))
      (newline)))))
