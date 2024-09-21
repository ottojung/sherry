;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (maybe-compile <filepath>)
  (cond-expand
   (guile (compile-file <filepath>))))

(define (load-procedure <filepath>)
  (fix-imports/generic #f <filepath>)
  (maybe-compile <filepath>)
  (load <filepath>))

(define (load-safely <filepath>)
  (catch-any
   (lambda whatever
     (load-procedure <filepath>))
   (lambda args
     (dprintln "Errored: ~s" args))))

(define (watch-file:loop <filepath>)
  (define old-time 0)
  (let loop ()
    (define time (file-mtime <filepath>))
    (unless (equal? time old-time)
      (newline (current-error-port))
      (display "------------------------------------------" (current-error-port))
      (newline (current-error-port))
      (display "Reloading..." (current-error-port))
      (newline (current-error-port))
      (load-safely <filepath>)
      (set! old-time (file-mtime <filepath>))
      (display "Done." (current-error-port))
      (newline (current-error-port))
      (display "------------------------------------------" (current-error-port))
      (newline (current-error-port)))
    (sys-usleep 20000)
    (loop)))

(define (watch-file <filepath>)
  (watch-file:loop <filepath>))
