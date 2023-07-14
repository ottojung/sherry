;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-module (sherry minify-license)
  :export (minify-license! minify-license/overwrite)
  :use-module ((euphrates properties) :select (set-property!))
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((euphrates string-strip) :select (string-strip))
  :use-module ((euphrates string-to-lines) :select (string->lines))
  :use-module ((euphrates words-to-string) :select (words->string))
  :use-module ((sherry file-license-exists-huh) :select (file-license-exists?))
  :use-module ((sherry infer-file-license) :select (infer-file-license))
  :use-module ((sherry license) :select (display-license license-prefix license-text))
  :use-module ((sherry licensedfile) :select (display-licensedfile file-license))
  :use-module ((sherry log) :select (log-info))
  )


(define (minify-license/overwrite --print filepath)
  (if (minify-license! filepath)
      (if --print
          (display-license (file-license filepath))
          (call-with-output-file
              filepath
            (lambda (p)
              (display-licensedfile filepath p))))
      (begin
        (log-info "File already has the minified license"))))


(define (minify-license! filepath)
  (define license-exists?
    (file-license-exists? filepath))

  (unless license-exists?
    (raisu 'file-does-not-have-the-license "File does not have the license"))

  (define current-license
    (infer-file-license filepath))

  (define current-text
    (license-text current-license))

  (define new-text
    (string-append
     (license-prefix current-license)
     (words->string
      (map (lambda (line) (string-strip line "; \t"))
           (string->lines current-text)))))

  (if (equal? current-text new-text) #f
      (set-property! (license-text current-license) new-text)))
