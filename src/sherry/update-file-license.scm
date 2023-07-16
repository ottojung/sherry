;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (update-file-license/overwrite --if-exists --all-years filepath)
  (define-values (up-to-date? license-exists?)
    (update-file-license --all-years filepath))
  (unless (and up-to-date? license-exists?)
    (when (or (and --if-exists license-exists?)
              (not --if-exists))
      (call-with-output-file
          filepath
        (lambda (p)
          (display-licensedfile filepath p))))))


(define (update-file-license --all-years filepath)
  (define license-exists? (file-license-exists? filepath))

  (unless license-exists?
    (log-info "Target file ~s does not have a license header" filepath))

  (define license (infer-file-license filepath))

  (unless license
    (raisu 'cannot-infer-the-license filepath))

  (define years (license-years license))

  (define up-to-date?
    (if --all-years
        (license-up-to-date?/all-years license)
        (license-up-to-date?/current-year license)))

  (define not-included-years
    (if --all-years
        (license-not-included-years/all-years license)
        (license-not-included-years/current-year license)))

  (cond
   (up-to-date?
    (log-info "Target file ~s has an up-to-date license" filepath))
   (license-exists?
    (log-info "Target file ~s has an outdated license" filepath)))

  (define new-license
    (if up-to-date?
        license
        (make-license
         filepath
         (cond
          (up-to-date? years)
          (license-exists? (append years not-included-years))
          (else (file-modification-years filepath)))
         (license-author license)
         (license-text license))))

  (unless up-to-date?
    (set-property! (file-license filepath) new-license))

  (values up-to-date? license-exists?))
