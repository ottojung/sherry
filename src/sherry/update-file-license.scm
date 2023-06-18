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

(define-module (sherry update-file-license)
  :export (update-file-license update-file-license/overwrite)
  :use-module ((sherry get-file-modification-years) :select (get-file-modification-years))
  :use-module ((sherry infer-file-license) :select (infer-file-license))
  :use-module ((sherry license) :select (license-author license-text license-years make-license))
  :use-module ((sherry licensedfile) :select (display-licensedfile licensedfile-license licensedfile-postlicense-content licensedfile-prelicense-content make-licensedfile parse-licensedfile))
  :use-module ((sherry log) :select (log-info))
  :use-module ((sherry year-in-years-huh) :select (year-in-years?))
  )


(define (update-file-license/overwrite --if-exists filepath)
  (define-values (up-to-date? license-exists? new-licensedfile)
    (update-file-license filepath))
  (unless (and up-to-date? license-exists?)
    (when (or (and --if-exists license-exists?)
              (not --if-exists))
      (call-with-output-file
          filepath
        (lambda (p)
          (display-licensedfile new-licensedfile p))))))


(define (update-file-license filepath)
  (define licensedfile
    (parse-licensedfile filepath))

  (define license-exists?
    (licensedfile-license licensedfile))

  (unless license-exists?
    (log-info "Target file ~s does not have a license header" filepath))

  (define current-license
    (infer-file-license filepath))

  (define years
    (license-years current-license))

  (define modification-years
    (get-file-modification-years filepath))

  (define not-included-years
    (filter (lambda (y) (not (year-in-years? y years)))
            modification-years))

  (define up-to-date?
    (and license-exists?
         (null? not-included-years)))

  (cond
   ((and up-to-date? license-exists?)
    (log-info "Target file ~s has an up-to-date license" filepath))
   (license-exists?
    (log-info "Target file ~a has an outdated license" filepath)))

  (define new-license
    (if (and up-to-date? license-exists?)
        current-license
        (make-license
         (cond
          ((and up-to-date? license-exists?) years)
          (license-exists? (append years not-included-years))
          (else modification-years))
         (license-author current-license)
         (license-text current-license))))

  (define new-licensedfile
    (if (and up-to-date? license-exists?)
        licensedfile
        (make-licensedfile
         (licensedfile-prelicense-content licensedfile)
         new-license
         (licensedfile-postlicense-content licensedfile))))

  (values up-to-date? license-exists? new-licensedfile))
