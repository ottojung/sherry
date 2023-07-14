;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-module (sherry licensedfile)
  :export (parse-licensedfile file-prelicense-content file-license file-postlicense-content display-licensedfile)
  :use-module ((euphrates fn-pair) :select (fn-pair))
  :use-module ((euphrates irregex) :select (irregex-match sre->irregex))
  :use-module ((euphrates lines-to-string) :select (lines->string))
  :use-module ((euphrates list-span-while) :select (list-span-while))
  :use-module ((euphrates properties) :select (define-property define-provider))
  :use-module ((euphrates range) :select (range))
  :use-module ((euphrates string-null-or-whitespace-p) :select (string-null-or-whitespace?))
  :use-module ((sherry file-lines) :select (file-lines))
  :use-module ((sherry license) :select (display-license license-text parse-license-from-lines))
  :use-module ((sherry shebang-line-huh) :select (shebang-line?))
  )

(define-property file-prelicense-content)
(define-property file-license)
(define-property file-postlicense-content)

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

(define-provider licensedp
  :targets (file-license file-prelicense-content file-postlicense-content)
  :sources (file-lines)

  (lambda (filepath)
    (define lines (file-lines filepath))

    (define-values
        (prelicense-content/0 after-prelicense-content/0)
      (list-span-while
       (fn-pair
        (i line)
        (and (equal? i 0)
             (shebang-line? line)))
       (map cons
            (range (length lines))
            lines)))

    (define prelicense-content/1 (map cdr prelicense-content/0))
    (define after-prelicense-content/1 (map cdr after-prelicense-content/0))

    (define-values
        (prelicense-whitespace after-prelicense)
      (list-span-while string-null-or-whitespace? after-prelicense-content/1))

    (define-values
        (license-header-line after-license-header)
      (if (null? after-prelicense)
          (values #f '())
          (let ((first (car after-prelicense)))
            (if (license-header-line? first)
                (values first (cdr after-prelicense))
                (values #f after-prelicense)))))

    (define-values
        (license-text after-license/0)
      (list-span-while license-line? after-license-header))

    (define license
      (and license-header-line
           (parse-license-from-lines
            (cons license-header-line license-text))))

    (values
     license
     (if license
         (append prelicense-content/1 prelicense-whitespace)
         prelicense-content/1)
     (if license
         after-license/0
         (append prelicense-whitespace
                 after-license/0)))))

(define display-licensedfile
  (case-lambda
   ((this) (display-licensedfile this (current-output-port)))
   ((this port)
    (parameterize ((current-output-port port))
      (for-each
       (lambda (line)
         (display line) (newline))
       (file-prelicense-content this))
      (display-license (file-license this))
      (display
       (lines->string
        (file-postlicense-content this)))))))
