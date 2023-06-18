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

(define-module (sherry license)
  :export (make-license license-author license-years license-text parse-license-from-lines display-license)
  :use-module ((euphrates define-type9) :select (define-type9))
  :use-module ((euphrates identity) :select (identity))
  :use-module ((euphrates irregex) :select (irregex-match-substring irregex-replace irregex-search sre->irregex))
  :use-module ((euphrates lines-to-string) :select (lines->string))
  :use-module ((euphrates list-intersperse) :select (list-intersperse))
  :use-module ((euphrates list-maximal-element-or) :select (list-maximal-element-or))
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((euphrates string-split-3) :select (string-split-3))
  :use-module ((euphrates string-strip) :select (string-strip))
  :use-module ((euphrates string-to-lines) :select (string->lines))
  :use-module ((euphrates string-to-words) :select (string->words))
  :use-module ((euphrates stringf) :select (stringf))
  :use-module ((euphrates tilda-a) :select (~a))
  :use-module ((euphrates words-to-string) :select (words->string))
  :use-module ((sherry yearsrange) :select (make-yearsrange))
  )


(define-type9 <license>
  (make-license years author text) license?
  (years license-years)
  (author license-author)
  (text license-text)
  )


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
               (else (values years (words->string rest))))))))))


(define (parse-license-from-lines lines)
  (if (null? lines) #f
      (let ()
        (define header-line (car lines))
        (define text (lines->string (cdr lines)))
        (define-values (years author) (parse-header-line header-line))
        (make-license years author text))))


(define license-get-prefix
  (let ((pre (sre->irregex '(seq bos (+ ";") (* (or " " "\t"))))))
    (lambda (license)
      (define lines
        (string->lines (license-text license)))
      (define matches
        (filter
         identity
         (map
          (lambda (line)
            (irregex-search pre line))
          lines)))

      (when (null? matches)
        (raisu 'unexpected-license-text license))

      (define prefixes
        (map irregex-match-substring matches))

      (list-maximal-element-or
       #f string-length prefixes))))


(define display-license
  (case-lambda
   ((license) (display-license license (current-output-port)))
   ((license port)
    (parameterize ((current-output-port port))
      (define pre (license-get-prefix license))
      (display pre)
      (display
       (words->string
        (cons
         "Copyright (C)"
         (list-intersperse
          "," (map ~a (license-years license))))))
      (display "  ")
      (display (license-author license))
      (newline)
      (display (license-text license))
      (newline)))))
