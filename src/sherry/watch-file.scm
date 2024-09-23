;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (maybe-compile <filepath>)
  ;; Actually, just interpret the thing.
  (define-values (scm-path sld-path)
    (if (string-suffix? ".sld" <filepath>)
        (let ((scm (path-replace-extension <filepath> ".scm")))
          (unless (file-or-directory-exists? scm)
            (log-error "Expected ~s file to exist." scm)
            (exit 1))
          (values scm <filepath>))
        (values <filepath> (path-replace-extension <filepath> ".sld"))))

  (parameterize ((default-optimization-level 0))
    (compile-file sld-path)))

(define (load-procedure <filepath>)
  ;; (fix-imports/generic #f <filepath>)
  (define comptime
    (with-run-time-estimate
     (maybe-compile <filepath>)))

  (log-info "Compiled in ~s seconds." comptime)

  (define runtime
    (with-run-time-estimate
     (load <filepath>)))

  (log-info "Execution took ~s seconds." runtime)

  (values))

(define (load-safely <filepath>)
  (catch-any
   (lambda whatever
     (load-procedure <filepath>))
   (lambda args
     (dprintln "Errored: ~s" args))))


(define (any-file-changed? files)
  (list-or-map file:externally-modified? files))


(define (update-files-timestamps! files)
  (for-each file:modification-time:update! files))


(define (watch-file:loop <filepath> files)
  (let loop ()
    (when (any-file-changed? files)
      (newline (current-error-port))
      (display "------------------------------------------" (current-error-port))
      (newline (current-error-port))
      (display "Reloading..." (current-error-port))
      (newline (current-error-port))
      (load-safely <filepath>)
      (update-files-timestamps! files)
      (display "Done." (current-error-port))
      (newline (current-error-port))
      (display "------------------------------------------" (current-error-port))
      (newline (current-error-port)))
    (sys-usleep 10000)
    (loop)))



(define (watch-file <filepath>)

  (define-values (scm-path sld-path)
    (if (string-suffix? ".sld" <filepath>)
        (let ((scm (path-replace-extension <filepath> ".scm")))
          (unless (file-or-directory-exists? scm)
            (log-error "Expected ~s file to exist." scm)
            (exit 1))
          (values scm <filepath>))
        (values <filepath> (path-replace-extension <filepath> ".sld"))))

  (watch-file:loop sld-path (list scm-path sld-path)))
