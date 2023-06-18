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


(define-module (sherry licensedfile)
  :export (parse-licensedfile parse-licensedfile-lines make-licensedfile licensedfile-prelicense-content licensedfile-license licensedfile-postlicense-content display-licensedfile)
  :use-module ((euphrates define-type9) :select (define-type9))
  :use-module ((euphrates fn-pair) :select (fn-pair))
  :use-module ((euphrates irregex) :select (irregex-match sre->irregex))
  :use-module ((euphrates lines-to-string) :select (lines->string))
  :use-module ((euphrates list-span-while) :select (list-span-while))
  :use-module ((euphrates range) :select (range))
  :use-module ((euphrates read-lines) :select (read/lines))
  :use-module ((euphrates string-null-or-whitespace-p) :select (string-null-or-whitespace?))
  :use-module ((sherry license) :select (display-license license-text parse-license-from-lines))
  :use-module ((sherry shebang-line-huh) :select (shebang-line?))
  )


(define-type9 <licensedfile>
  (make-licensedfile prelicense-content license postlicense-content) licensedfile?
  (prelicense-content licensedfile-prelicense-content)
  (license licensedfile-license)
  (postlicense-content licensedfile-postlicense-content)
  )


(define license-line?
  (lambda (line)
    (string-prefix? ";" line)))


(define license-header-line?
  (let ((r (sre->irregex
            '(seq (+ ";")
                  (* whitespace)
                  (w/nocase "Copyright")
                  (* whitespace)
                  (w/nocase "(C)")
                  (* any)))))
    (lambda (line)
      (irregex-match r line))))

(define (parse-licensedfile filepath)
  (parse-licensedfile-lines (read/lines filepath)))

(define (parse-licensedfile-lines lines)
  (define-values
      (prelicense-content/0 after-prelicense/0)
    (list-span-while
     (fn-pair
      (i line)
      (or (and (equal? i 0)
               (shebang-line? line))
          (string-null-or-whitespace? line)))
     (map cons
          (range (length lines))
          lines)))

  (define prelicense-content (map cdr prelicense-content/0))
  (define after-prelicense (map cdr after-prelicense/0))

  (define-values
      (license-header-line after-license-header)
    (if (null? after-prelicense)
        (values #f '())
        (let ((first (car after-prelicense)))
          (if (license-header-line? first)
              (values first (cdr after-prelicense))
              (values #f after-prelicense)))))

  (define-values
      (license-text after-license)
    (list-span-while license-line? after-license-header))

  (define license
    (and license-header-line
         (parse-license-from-lines
          (cons license-header-line license-text))))

  (make-licensedfile
   prelicense-content
   license
   after-license))

(define display-licensedfile
  (case-lambda
   ((this) (display-licensedfile this (current-output-port)))
   ((this port)
    (parameterize ((current-output-port port))
      (display (lines->string (licensedfile-prelicense-content this)))
      (display-license (licensedfile-license this))
      (display (lines->string (licensedfile-postlicense-content this)))))))