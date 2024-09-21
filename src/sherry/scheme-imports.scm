;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (fatal fmt . args)
  (parameterize ((current-output-port (current-error-port)))
    (apply dprintln (cons fmt args)))
  (exit 1))

(define (warn fmt . args)
  (parameterize ((current-output-port (current-error-port)))
    (apply dprintln (cons fmt args))))

(define (fully-flatten lst)
  (let loop ((lst lst))
    (cond
     ((pair? lst)
      (append (filter identity (loop (car lst)))
              (filter identity (loop (cdr lst)))))
     ((symbol? lst) (list lst))
     (else (list #f)))))

(define r7rs-stdlib-exports
  '((reverse "scheme/base.scm") (cddddr "scheme/cxr.scm") (string->utf8 "scheme/base.scm") (cadddr "scheme/cxr.scm") (exact-integer-sqrt "scheme/base.scm") (guard "scheme/base.scm") (bytevector-length "scheme/base.scm") (peek-u8 "scheme/base.scm") (assv "scheme/base.scm") (caddar "scheme/cxr.scm") (cdaadr "scheme/cxr.scm") (string-length "scheme/base.scm") (cadadr "scheme/cxr.scm") (call-with-port "scheme/base.scm") (letrec "scheme/base.scm") (string-fill! "scheme/base.scm") (make-list "scheme/base.scm") (let*-values "scheme/base.scm") (eof-object? "scheme/base.scm") (char-lower-case? "scheme/char.scm") (environment "scheme/eval.scm") (vector-copy "scheme/base.scm") (syntax-rules "scheme/base.scm") (equal? "scheme/base.scm") (let* "scheme/base.scm") (null? "scheme/base.scm") (vector->string "scheme/base.scm") (cdaar "scheme/cxr.scm") (number->string "scheme/base.scm") (caaadr "scheme/cxr.scm") (string-ci<? "scheme/char.scm") (map "scheme/base.scm") (cadr "scheme/base.scm") (set! "scheme/base.scm") (vector-length "scheme/base.scm") (char=? "scheme/base.scm") (vector-for-each "scheme/base.scm") (char>=? "scheme/base.scm") (open-binary-input-file "scheme/file.scm") (cdadar "scheme/cxr.scm") (open-binary-output-file "scheme/file.scm") (do "scheme/base.scm") (max "scheme/base.scm") (vector-append "scheme/base.scm") (infinite? "scheme/inexact.scm") (input-port? "scheme/base.scm") (< "scheme/base.scm") (output-port-open? "scheme/base.scm") (nan? "scheme/inexact.scm") (number? "scheme/base.scm") (make-parameter "scheme/base.scm") (quotient "scheme/base.scm") (char<=? "scheme/base.scm") (=> "scheme/base.scm") (sqrt "scheme/inexact.scm") (cdaddr "scheme/cxr.scm") (include-ci "scheme/base.scm") (string=? "scheme/base.scm") (set-cdr! "scheme/base.scm") (log "scheme/inexact.scm") (floor-remainder "scheme/base.scm") (bytevector "scheme/base.scm") (error "scheme/base.scm") (letrec-syntax "scheme/base.scm") (assoc "scheme/base.scm") (write-string "scheme/base.scm") (caar "scheme/base.scm") (call/cc "scheme/base.scm") (emergency-exit "scheme/process-context.scm") (else "scheme/base.scm") (cddr "scheme/base.scm") (write-shared "scheme/write.scm") (with-output-to-file "scheme/file.scm") (let-values "scheme/base.scm") (delay-force "scheme/lazy.scm") (call-with-output-file "scheme/file.scm") (define-values "scheme/base.scm") (cdddar "scheme/cxr.scm") (get-environment-variable "scheme/process-context.scm") (vector? "scheme/base.scm") (set-car! "scheme/base.scm") (string-for-each "scheme/base.scm") (jiffies-per-second "scheme/time.scm") (read-error? "scheme/base.scm") (close-port "scheme/base.scm") (truncate "scheme/base.scm") (u8-ready? "scheme/base.scm") (peek-char "scheme/base.scm") (open-input-string "scheme/base.scm") (char-ready? "scheme/base.scm") (memv "scheme/base.scm") (char-ci<=? "scheme/char.scm") (vector-fill! "scheme/base.scm") (read "scheme/read.scm") (round "scheme/base.scm") (cdar "scheme/base.scm") (command-line "scheme/process-context.scm") (char? "scheme/base.scm") (floor-quotient "scheme/base.scm") (begin "scheme/base.scm") (>= "scheme/base.scm") (integer? "scheme/base.scm") (null-environment "scheme/r5rs.scm") (list "scheme/base.scm") (open-output-bytevector "scheme/base.scm") (char>? "scheme/base.scm") (- "scheme/base.scm") (length "scheme/base.scm") (close-output-port "scheme/base.scm") (caaddr "scheme/cxr.scm") (string-set! "scheme/base.scm") (flush-output-port "scheme/base.scm") (string<? "scheme/base.scm") (make-polar "scheme/complex.scm") (member "scheme/base.scm") (close-input-port "scheme/base.scm") (read-char "scheme/base.scm") (real? "scheme/base.scm") (make-string "scheme/base.scm") (apply "scheme/base.scm") (read-line "scheme/base.scm") (newline "scheme/base.scm") (eof-object "scheme/base.scm") (bytevector-u8-ref "scheme/base.scm") (lcm "scheme/base.scm") (exp "scheme/inexact.scm") (cons "scheme/base.scm") (list->string "scheme/base.scm") (char<? "scheme/base.scm") (define "scheme/base.scm") (cdr "scheme/base.scm") (string-ci>? "scheme/char.scm") (write-u8 "scheme/base.scm") (string-append "scheme/base.scm") (procedure? "scheme/base.scm") (string-copy "scheme/base.scm") (inexact? "scheme/base.scm") (denominator "scheme/base.scm") (quasiquote "scheme/base.scm") (write-bytevector "scheme/base.scm") (error-object-irritants "scheme/base.scm") (positive? "scheme/base.scm") (square "scheme/base.scm") (+ "scheme/base.scm") (eval "scheme/eval.scm") (modulo "scheme/base.scm") (... "scheme/base.scm") (expt "scheme/base.scm") (string<=? "scheme/base.scm") (let "scheme/base.scm") (symbol->string "scheme/base.scm") (char-upper-case? "scheme/char.scm") (exact-integer? "scheme/base.scm") (lambda "scheme/base.scm") (truncate-remainder "scheme/base.scm") (sin "scheme/inexact.scm") (delay "scheme/lazy.scm") (open-output-file "scheme/file.scm") (string->list "scheme/base.scm") (vector-ref "scheme/base.scm") (* "scheme/base.scm") (string>? "scheme/base.scm") (write-simple "scheme/write.scm") (current-jiffy "scheme/time.scm") (caaaar "scheme/cxr.scm") (string-ci>=? "scheme/char.scm") (textual-port? "scheme/base.scm") (_ "scheme/base.scm") (floor "scheme/base.scm") (scheme-report-environment "scheme/r5rs.scm") (caddr "scheme/cxr.scm") (get-output-bytevector "scheme/base.scm") (atan "scheme/inexact.scm") (cos "scheme/inexact.scm") (string-downcase "scheme/char.scm") (caaar "scheme/cxr.scm") (cddaar "scheme/cxr.scm") (rationalize "scheme/base.scm") (open-output-string "scheme/base.scm") (symbol? "scheme/base.scm") (exact? "scheme/base.scm") (caadar "scheme/cxr.scm") (magnitude "scheme/complex.scm") (and "scheme/base.scm") (port? "scheme/base.scm") (make-promise "scheme/lazy.scm") (memq "scheme/base.scm") (= "scheme/base.scm") (complex? "scheme/base.scm") (case-lambda "scheme/case-lambda.scm") (with-input-from-file "scheme/file.scm") (raise-continuable "scheme/base.scm") (with-exception-handler "scheme/base.scm") (open-input-file "scheme/file.scm") (read-u8 "scheme/base.scm") (car "scheme/base.scm") (rational? "scheme/base.scm") (bytevector-copy "scheme/base.scm") (let-syntax "scheme/base.scm") (open-input-bytevector "scheme/base.scm") (include "scheme/base.scm") (char-alphabetic? "scheme/char.scm") (current-input-port "scheme/base.scm") (boolean=? "scheme/base.scm") (string->symbol "scheme/base.scm") (bytevector-append "scheme/base.scm") (string-ci<=? "scheme/char.scm") (exact "scheme/base.scm") (when "scheme/base.scm") (<= "scheme/base.scm") (char-foldcase "scheme/char.scm") (read-bytevector "scheme/base.scm") (cond-expand "scheme/base.scm") (utf8->string "scheme/base.scm") (force "scheme/lazy.scm") (symbol=? "scheme/base.scm") (define-syntax "scheme/base.scm") (cdddr "scheme/cxr.scm") (exit "scheme/process-context.scm") (exact->inexact "scheme/r5rs.scm") (syntax-error "scheme/base.scm") (make-bytevector "scheme/base.scm") (write-char "scheme/base.scm") (zero? "scheme/base.scm") (get-environment-variables "scheme/process-context.scm") (cdadr "scheme/cxr.scm") (abs "scheme/base.scm") (or "scheme/base.scm") (digit-value "scheme/char.scm") (char-numeric? "scheme/char.scm") (char-downcase "scheme/char.scm") (current-output-port "scheme/base.scm") (char-ci<? "scheme/char.scm") (bytevector? "scheme/base.scm") (eqv? "scheme/base.scm") (bytevector-u8-set! "scheme/base.scm") (vector "scheme/base.scm") (eq? "scheme/base.scm") (char-ci>? "scheme/char.scm") (finite? "scheme/inexact.scm") (char-upcase "scheme/char.scm") (unquote "scheme/base.scm") (asin "scheme/inexact.scm") (inexact "scheme/base.scm") (case "scheme/base.scm") (even? "scheme/base.scm") (substring "scheme/base.scm") (/ "scheme/base.scm") (char->integer "scheme/base.scm") (vector->list "scheme/base.scm") (string "scheme/base.scm") (list-copy "scheme/base.scm") (promise? "scheme/lazy.scm") (acos "scheme/inexact.scm") (for-each "scheme/base.scm") (dynamic-wind "scheme/base.scm") (letrec* "scheme/base.scm") (string->number "scheme/base.scm") (tan "scheme/inexact.scm") (output-port? "scheme/base.scm") (char-ci=? "scheme/char.scm") (delete-file "scheme/file.scm") (floor/ "scheme/base.scm") (vector-copy! "scheme/base.scm") (remainder "scheme/base.scm") (call-with-values "scheme/base.scm") (write "scheme/write.scm") (string-ci=? "scheme/char.scm") (error-object? "scheme/base.scm") (binary-port? "scheme/base.scm") (string-foldcase "scheme/char.scm") (cadar "scheme/cxr.scm") (list-tail "scheme/base.scm") (negative? "scheme/base.scm") (current-error-port "scheme/base.scm") (make-rectangular "scheme/complex.scm") (interaction-environment "scheme/repl.scm") (real-part "scheme/complex.scm") (list-set! "scheme/base.scm") (char-whitespace? "scheme/char.scm") (ceiling "scheme/base.scm") (define-record-type "scheme/base.scm") (string-copy! "scheme/base.scm") (call-with-input-file "scheme/file.scm") (inexact->exact "scheme/r5rs.scm") (> "scheme/base.scm") (raise "scheme/base.scm") (bytevector-copy! "scheme/base.scm") (odd? "scheme/base.scm") (current-second "scheme/time.scm") (string-map "scheme/base.scm") (list->vector "scheme/base.scm") (cddadr "scheme/cxr.scm") (not "scheme/base.scm") (call-with-current-continuation "scheme/base.scm") (integer->char "scheme/base.scm") (boolean? "scheme/base.scm") (imag-part "scheme/complex.scm") (list-ref "scheme/base.scm") (file-error? "scheme/base.scm") (assq "scheme/base.scm") (gcd "scheme/base.scm") (make-vector "scheme/base.scm") (input-port-open? "scheme/base.scm") (parameterize "scheme/base.scm") (string-ref "scheme/base.scm") (pair? "scheme/base.scm") (append "scheme/base.scm") (get-output-string "scheme/base.scm") (unquote-splicing "scheme/base.scm") (display "scheme/write.scm") (truncate-quotient "scheme/base.scm") (cond "scheme/base.scm") (string->vector "scheme/base.scm") (values "scheme/base.scm") (if "scheme/base.scm") (caadr "scheme/cxr.scm") (min "scheme/base.scm") (load "scheme/load.scm") (unless "scheme/base.scm") (string? "scheme/base.scm") (cadaar "scheme/cxr.scm") (truncate/ "scheme/base.scm") (char-ci>=? "scheme/char.scm") (file-exists? "scheme/file.scm") (string>=? "scheme/base.scm") (quote "scheme/base.scm") (string-upcase "scheme/char.scm") (list? "scheme/base.scm") (angle "scheme/complex.scm") (cddar "scheme/cxr.scm") (error-object-message "scheme/base.scm") (numerator "scheme/base.scm") (read-bytevector! "scheme/base.scm") (vector-set! "scheme/base.scm") (features "scheme/base.scm") (read-string "scheme/base.scm") (cdaaar "scheme/cxr.scm") (vector-map "scheme/base.scm")
    (lazy "srfi/45.scm") (logand "srfi/60.scm") (f64vector "srfi/4.scm") (delay "srfi/45.scm") (assoc "srfi/1.scm") (vector-index-right "srfi/43.scm") (date-day "srfi/19.scm") (mutex-state "srfi/18.scm") (define-record-type "srfi/9.scm") (vector->list "srfi/43.scm") (current-date "srfi/19.scm") (time>? "srfi/19.scm") (:string "srfi/42.scm") (list->integer "srfi/60.scm") (make-list "srfi/1.scm") (subtract-duration "srfi/19.scm") (date->time-monotonic "srfi/19.scm") (s8vector? "srfi/4.scm") (u8vector->list "srfi/4.scm") (map! "srfi/1.scm") (values->vector "srfi/71.scm") (option-required-arg? "srfi/37.scm") (s16vector? "srfi/4.scm") (:-dispatch-set! "srfi/42.scm") (fifth "srfi/1.scm") (make-parameter "srfi/39.scm") (current-input-port "srfi/39.scm") (set-time-second! "srfi/19.scm") (&error "srfi/35.scm") (thread-start! "srfi/18.scm") (port->stream "srfi/41.scm") (tappend-map "srfi/171.scm") (tlog "srfi/171.scm") (car+cdr "srfi/1.scm") (condition-message "srfi/35.scm") (lset-adjoin "srfi/1.scm") (let-values "srfi/11.scm") (rec "srfi/31.scm") (vector-ref "srfi/17.scm") (alist-delete "srfi/1.scm") (option-names "srfi/37.scm") (append "srfi/1.scm") (compare-by=/> "srfi/67.scm") (receive "srfi/8.scm") (sixth "srfi/1.scm") (test-expect-fail "srfi/64.scm") (u8vector? "srfi/4.scm") (cddr "srfi/1.scm") (lset-union "srfi/1.scm") (:let "srfi/42.scm") (test-runner-on-group-begin "srfi/64.scm") (rcount "srfi/171.scm") (test-result-ref "srfi/64.scm") (mutex-name "srfi/18.scm") (&serious "srfi/35.scm") (lset-xor! "srfi/1.scm") (let*-values "srfi/11.scm") (first "srfi/1.scm") (date->julian-day "srfi/19.scm") (u64vector "srfi/4.scm") (test-apply "srfi/64.scm") (fold-right "srfi/1.scm") (test-runner-factory "srfi/64.scm") (bit-count "srfi/60.scm") (port-transduce "srfi/171.scm") (current-thread "srfi/18.scm") (define-stream "srfi/41.scm") (test-on-bad-end-name-simple "srfi/64.scm") (vector-fill! "srfi/43.scm") (:dispatched "srfi/42.scm") (cdr "srfi/1.scm") (unvector "srfi/71.scm") (vector-empty? "srfi/43.scm") (delete-duplicates! "srfi/1.scm") (vector-map! "srfi/43.scm") (set-car! "srfi/1.scm") (thread-terminate! "srfi/18.scm") (unzip3 "srfi/1.scm") (time-nanosecond "srfi/19.scm") (lset-diff+intersection "srfi/1.scm") (let* "srfi/71.scm") (dispatch-union "srfi/42.scm") (condition-type? "srfi/35.scm") (stream-drop "srfi/41.scm") (time-utc->time-tai! "srfi/19.scm") (:-dispatch-ref "srfi/42.scm") (vector-skip-right "srfi/43.scm") (unfold-right "srfi/1.scm") (time=? "srfi/19.scm") (make-s16vector "srfi/4.scm") (test-result-clear "srfi/64.scm") (args-fold "srfi/37.scm") (test-skip "srfi/64.scm") (s8vector->list "srfi/4.scm") (time-utc->time-monotonic! "srfi/19.scm") (list-ref "srfi/1.scm") (u16vector->list "srfi/4.scm") (take! "srfi/1.scm") (message-condition? "srfi/35.scm") (test-result-set! "srfi/64.scm") (filter! "srfi/1.scm") (vector-map "srfi/43.scm") (current-error-port "srfi/39.scm") (test-runner-fail-count "srfi/64.scm") (test-runner-on-group-end "srfi/64.scm") (vector-compare-as-list "srfi/67.scm") (reverse-vector->list "srfi/43.scm") (f64vector-ref "srfi/4.scm") (and-let* "srfi/2.scm") (time<? "srfi/19.scm") (vector-skip "srfi/43.scm") (make-u32vector "srfi/4.scm") (s16vector-length "srfi/4.scm") (count "srfi/1.scm") (current-julian-day "srfi/19.scm") (logxor "srfi/60.scm") (cdadr "srfi/1.scm") (guard "srfi/34.scm") (s16vector-set! "srfi/4.scm") (s32vector-length "srfi/4.scm") (cdaadr "srfi/1.scm") (unzip1 "srfi/1.scm") (delete! "srfi/1.scm") (circular-list? "srfi/1.scm") (</<? "srfi/67.scm") (unzip5 "srfi/1.scm") (time-utc->time-tai "srfi/19.scm") (delete-duplicates "srfi/1.scm") (test-runner-xfail-count "srfi/64.scm") (test-runner-null "srfi/64.scm") (unfold "srfi/1.scm") (chain=? "srfi/67.scm") (date-year-day "srfi/19.scm") (caaddr "srfi/1.scm") (time-utc->julian-day "srfi/19.scm") (tadd-between "srfi/171.scm") (time-tai->time-monotonic "srfi/19.scm") (condition-has-type? "srfi/35.scm") (</<=? "srfi/67.scm") (u16vector-length "srfi/4.scm") (time-thread "srfi/19.scm") (memv "srfi/1.scm") (reverse-rcons "srfi/171.scm") (:integers "srfi/42.scm") (list-compare-as-vector "srfi/67.scm") (fold "srfi/1.scm") (fold3-ec "srfi/42.scm") (:real-range "srfi/42.scm") (get-environment-variables "srfi/98.scm") (time-type "srfi/19.scm") (cadddr "srfi/1.scm") (list->u16vector "srfi/4.scm") (if-not=? "srfi/67.scm") (bitwise-ior "srfi/60.scm") (time-utc->time-monotonic "srfi/19.scm") (modified-julian-day->time-utc "srfi/19.scm") (string-transduce "srfi/171.scm") (mutex-unlock! "srfi/18.scm") (time-monotonic "srfi/19.scm") (stream-zip "srfi/41.scm") (first-ec "srfi/42.scm") (copy-bit-field "srfi/60.scm") (cddar "srfi/1.scm") (do-ec "srfi/42.scm") (caddar "srfi/1.scm") (list-ec "srfi/42.scm") (vector-set! "srfi/43.scm") (&message "srfi/35.scm") (cdar "srfi/1.scm") (date->modified-julian-day "srfi/19.scm") (rcons "srfi/171.scm") (time-tai->time-utc! "srfi/19.scm") (test-passed? "srfi/64.scm") (u8vector "srfi/4.scm") (time-tai->modified-julian-day "srfi/19.scm") (stream-let "srfi/41.scm") (vector-swap! "srfi/43.scm") (time-tai->time-monotonic! "srfi/19.scm") (string-append-ec "srfi/42.scm") (compare-by< "srfi/67.scm") (stream-unfold "srfi/41.scm") (tenumerate "srfi/171.scm") (u16vector-ref "srfi/4.scm") (make-s8vector "srfi/4.scm") (unzip4 "srfi/1.scm") (time>=? "srfi/19.scm") (u32vector-set! "srfi/4.scm") (getter-with-setter "srfi/17.scm") (list->stream "srfi/41.scm") (condition-variable-broadcast! "srfi/18.scm") (memq "srfi/1.scm") (date-week-day "srfi/19.scm") (read-with-shared-structure "srfi/38.scm") (bitwise-and "srfi/60.scm") (s32vector-set! "srfi/4.scm") (any "srfi/1.scm") (test-on-group-begin-simple "srfi/64.scm") (stream-null "srfi/41.scm") (time-utc->date "srfi/19.scm") (drop-right! "srfi/1.scm") (julian-day->time-tai "srfi/19.scm") (f32vector-length "srfi/4.scm") (partition! "srfi/1.scm") (thread-sleep! "srfi/18.scm") (condition? "srfi/35.scm") (vector-for-each "srfi/43.scm") (partition "srfi/1.scm") (error? "srfi/35.scm") (date->time-utc "srfi/19.scm") (stream-range "srfi/41.scm") (time-duration "srfi/19.scm") (tflatten "srfi/171.scm") (add-duration "srfi/19.scm") (split-at "srfi/1.scm") (vector-unfold-right "srfi/43.scm") (u32vector-length "srfi/4.scm") (keyword? "srfi/88.scm") (:until "srfi/42.scm") (lset-intersection! "srfi/1.scm") (u64vector-ref "srfi/4.scm") (thread-specific-set! "srfi/18.scm") (refine-compare "srfi/67.scm") (list->s8vector "srfi/4.scm") (terminated-thread-exception? "srfi/18.scm") (abandoned-mutex-exception? "srfi/18.scm") (logior "srfi/60.scm") (cons "srfi/1.scm") (remove! "srfi/1.scm") (cons* "srfi/1.scm") (test-runner-pass-count "srfi/64.scm") (last "srfi/1.scm") (cdaaar "srfi/1.scm") (bitwise-merge "srfi/60.scm") (time-process "srfi/19.scm") (string->date "srfi/19.scm") (if>? "srfi/67.scm") (stream-cdr "srfi/41.scm") (make-mutex "srfi/18.scm") (u64vector? "srfi/4.scm") (raise "srfi/18.scm") (string->keyword "srfi/88.scm") (append-map! "srfi/1.scm") (stream-unfolds "srfi/41.scm") (make-condition-type "srfi/35.scm") (time-monotonic->time-tai! "srfi/19.scm") (u64vector-set! "srfi/4.scm") (test-match-any "srfi/64.scm") (list->vector "srfi/43.scm") (stream-pair? "srfi/41.scm") (member "srfi/1.scm") (julian-day->date "srfi/19.scm") (find-tail "srfi/1.scm") (vector? "srfi/43.scm") (every "srfi/1.scm") (list->s32vector "srfi/4.scm") (max-compare "srfi/67.scm") (s32vector->list "srfi/4.scm") (caar "srfi/1.scm") (vector-of-length-ec "srfi/42.scm") (boolean-compare "srfi/67.scm") (caadar "srfi/1.scm") (time-difference "srfi/19.scm") (>/>? "srfi/67.scm") (iota "srfi/1.scm") (assv "srfi/1.scm") (concatenate "srfi/1.scm") (stream-of "srfi/41.scm") (caaar "srfi/1.scm") (max-ec "srfi/42.scm") (rany "srfi/171.scm") (test-runner-aux-value "srfi/64.scm") (make-condition-variable "srfi/18.scm") (number-compare "srfi/67.scm") (concatenate! "srfi/1.scm") (delete "srfi/1.scm") (select-compare "srfi/67.scm") (s32vector-ref "srfi/4.scm") (test-result-remove "srfi/64.scm") (s8vector-ref "srfi/4.scm") (u32vector "srfi/4.scm") (set-time-type! "srfi/19.scm") (list->f64vector "srfi/4.scm") (vector-reverse-copy "srfi/43.scm") (vector-count "srfi/43.scm") (test-end "srfi/64.scm") (find "srfi/1.scm") (>=/>=? "srfi/67.scm") (vector-fold-right "srfi/43.scm") (arithmetic-shift "srfi/60.scm") (date-second "srfi/19.scm") (pair? "srfi/1.scm") (lset= "srfi/1.scm") (with-parameters* "srfi/39.scm") (cddadr "srfi/1.scm") (first-set-bit "srfi/60.scm") (test-runner-fail-count! "srfi/64.scm") (make-f32vector "srfi/4.scm") (test-runner-on-bad-count! "srfi/64.scm") (compare-by>= "srfi/67.scm") (test-begin "srfi/64.scm") (u8vector-length "srfi/4.scm") (serious-condition? "srfi/35.scm") (test-log-to-file "srfi/64.scm") (f32vector->list "srfi/4.scm") (test-on-bad-count-simple "srfi/64.scm") (vector-every "srfi/43.scm") (last-pair "srfi/1.scm") (modified-julian-day->date "srfi/19.scm") (f32vector-ref "srfi/4.scm") (lset<= "srfi/1.scm") (reverse! "srfi/1.scm") (stream-iterate "srfi/41.scm") (lset-union! "srfi/1.scm") (test-runner-on-bad-end-name "srfi/64.scm") (date-nanosecond "srfi/19.scm") (tfilter "srfi/171.scm") (take "srfi/1.scm") (f64vector-length "srfi/4.scm") (vector-reverse-copy! "srfi/43.scm") (treplace "srfi/171.scm") (make-u16vector "srfi/4.scm") (stream-map "srfi/41.scm") (list-transduce "srfi/171.scm") (length "srfi/1.scm") (parameterize "srfi/39.scm") (condition-variable-specific-set! "srfi/18.scm") (date->string "srfi/19.scm") (time-tai->julian-day "srfi/19.scm") (test-runner-on-bad-count "srfi/64.scm") (vector-index "srfi/43.scm") (u32vector? "srfi/4.scm") (product-ec "srfi/42.scm") (caaadr "srfi/1.scm") (integer-length "srfi/60.scm") (bitwise-if "srfi/60.scm") (compare-by> "srfi/67.scm") (stream->list "srfi/41.scm") (stream-for-each "srfi/41.scm") (tsegment "srfi/171.scm") (alist-delete! "srfi/1.scm") (list-compare "srfi/67.scm") (=? "srfi/67.scm") (test-assert "srfi/64.scm") (second "srfi/1.scm") (vector "srfi/43.scm") (thread? "srfi/18.scm") (tdelete-neighbor-duplicates "srfi/171.scm") (list= "srfi/1.scm") (unlist "srfi/71.scm") (u8vector-ref "srfi/4.scm") (stream-take-while "srfi/41.scm") (test-runner-on-group-begin! "srfi/64.scm") (time-monotonic->time-utc "srfi/19.scm") (time-monotonic->time-tai "srfi/19.scm") (pair-compare-car "srfi/67.scm") (list->s16vector "srfi/4.scm") (letrec "srfi/71.scm") (not-pair? "srfi/1.scm") (vector-concatenate "srfi/43.scm") (alist-copy "srfi/1.scm") (s16vector "srfi/4.scm") (lset-difference "srfi/1.scm") (span! "srfi/1.scm") (vector-any "srfi/43.scm") (test-error "srfi/64.scm") (lset-diff+intersection! "srfi/1.scm") (:generator-proc "srfi/42.scm") (take-right "srfi/1.scm") (current-exception-handler "srfi/18.scm") (time-utc->modified-julian-day "srfi/19.scm") (string-compare "srfi/67.scm") (sum-ec "srfi/42.scm") (circular-list "srfi/1.scm") (modified-julian-day->time-monotonic "srfi/19.scm") (if>=? "srfi/67.scm") (uncaught-exception-reason "srfi/18.scm") (test-on-group-end-simple "srfi/64.scm") (chain<? "srfi/67.scm") (condition-variable? "srfi/18.scm") (:range "srfi/42.scm") (test-runner-on-test-end "srfi/64.scm") (vector-length "srfi/43.scm") (filter "srfi/1.scm") (test-runner-on-final! "srfi/64.scm") (vector-reverse! "srfi/43.scm") (bit-field "srfi/60.scm") (thread-specific "srfi/18.scm") (test-runner-on-final "srfi/64.scm") (vector-ec "srfi/42.scm") (test-runner-group-path "srfi/64.scm") (eighth "srfi/1.scm") (s64vector-set! "srfi/4.scm") (list->u32vector "srfi/4.scm") (xcons "srfi/1.scm") (:do "srfi/42.scm") (test-runner-on-bad-end-name! "srfi/64.scm") (stream-fold "srfi/41.scm") (option "srfi/37.scm") (third "srfi/1.scm") (test-runner-on-group-end! "srfi/64.scm") (current-output-port "srfi/39.scm") (tdrop-while "srfi/171.scm") (open-input-string "srfi/6.scm") (mutex-specific "srfi/18.scm") (every?-ec "srfi/42.scm") (fourth "srfi/1.scm") (ttake-while "srfi/171.scm") (cdadar "srfi/1.scm") (logbit? "srfi/60.scm") (cddddr "srfi/1.scm") (stream-car "srfi/41.scm") (s64vector->list "srfi/4.scm") (tconcatenate "srfi/171.scm") (date-minute "srfi/19.scm") (vector-copy! "srfi/43.scm") (tmap "srfi/171.scm") (set-cdr! "srfi/1.scm") (if3 "srfi/67.scm") (filter-map "srfi/1.scm") (cddaar "srfi/1.scm") (subtract-duration! "srfi/19.scm") (debug-compare "srfi/67.scm") (current-time "srfi/18.scm") (modified-julian-day->time-tai "srfi/19.scm") (define-reader-ctor "srfi/10.scm") (date-zone-offset "srfi/19.scm") (test-result-alist! "srfi/64.scm") (extract-condition "srfi/35.scm") (s32vector? "srfi/4.scm") (time-tai->time-utc "srfi/19.scm") (chain<=? "srfi/67.scm") (vector-compare "srfi/67.scm") (integer-compare "srfi/67.scm") (generator-transduce "srfi/171.scm") (u8vector-set! "srfi/4.scm") (mutex? "srfi/18.scm") (keyword->string "srfi/88.scm") (length+ "srfi/1.scm") (char-compare-ci "srfi/67.scm") (vector-append "srfi/43.scm") (list->u64vector "srfi/4.scm") (list->f32vector "srfi/4.scm") (vector-copy "srfi/43.scm") (last-ec "srfi/42.scm") (list-tabulate "srfi/1.scm") (min-compare "srfi/67.scm") (reduce "srfi/1.scm") (s64vector? "srfi/4.scm") (cadar "srfi/1.scm") (test-runner-on-test-begin! "srfi/64.scm") (split-at! "srfi/1.scm") (u64vector-length "srfi/4.scm") (:port "srfi/42.scm") (time-second "srfi/19.scm") (revery "srfi/171.scm") (compare-by<= "srfi/67.scm") (stream? "srfi/41.scm") (test-runner-aux-value! "srfi/64.scm") (vector= "srfi/43.scm") (stream-match "srfi/41.scm") (unzip2 "srfi/1.scm") (pair-compare "srfi/67.scm") (time-tai "srfi/19.scm") (stream-null? "srfi/41.scm") (define-condition-type "srfi/35.scm") (f64vector->list "srfi/4.scm") (reduce-right "srfi/1.scm") (condition "srfi/35.scm") (cadadr "srfi/1.scm") (:vector "srfi/42.scm") (test-equal "srfi/64.scm") (make-s64vector "srfi/4.scm") (:parallel "srfi/42.scm") (stream-drop-while "srfi/41.scm") (test-on-final-simple "srfi/64.scm") (list-index "srfi/1.scm") (time<=? "srfi/19.scm") (vector-fold "srfi/43.scm") (append-ec "srfi/42.scm") (test-runner-simple "srfi/64.scm") (date-hour "srfi/19.scm") (time-monotonic->modified-julian-day "srfi/19.scm") (u32vector->list "srfi/4.scm") (drop "srfi/1.scm") (julian-day->time-utc "srfi/19.scm") (test-runner-on-test-end! "srfi/64.scm") (bit-set? "srfi/60.scm") (seventh "srfi/1.scm") (test-group-with-cleanup "srfi/64.scm") (any?-ec "srfi/42.scm") (make-u64vector "srfi/4.scm") (s64vector "srfi/4.scm") (test-runner-test-name "srfi/64.scm") (condition-variable-name "srfi/18.scm") (cdaddr "srfi/1.scm") (cdaar "srfi/1.scm") (for-each "srfi/1.scm") (stream-take "srfi/41.scm") (reverse "srfi/1.scm") (date-week-number "srfi/19.scm") (stream-cons "srfi/41.scm") (complex-compare "srfi/67.scm") (test-runner-on-test-begin "srfi/64.scm") (uncons "srfi/71.scm") (:char-range "srfi/42.scm") (any-bits-set? "srfi/60.scm") (proper-list? "srfi/1.scm") (s64vector-ref "srfi/4.scm") (u16vector-set! "srfi/4.scm") (bitwise-xor "srfi/60.scm") (make-initial-:-dispatch "srfi/42.scm") (stream-ref "srfi/41.scm") (:while "srfi/42.scm") (if<? "srfi/67.scm") (test-result-kind "srfi/64.scm") (kth-largest "srfi/67.scm") (test-runner-reset "srfi/64.scm") (cadr "srfi/1.scm") (>? "srfi/67.scm") (current-modified-julian-day "srfi/19.scm") (let "srfi/71.scm") (default-compare "srfi/67.scm") (string-ec "srfi/42.scm") (vector-unfold "srfi/43.scm") (ttake "srfi/171.scm") (cadaar "srfi/1.scm") (tpartition "srfi/171.scm") (tfilter-map "srfi/171.scm") (u32vector-ref "srfi/4.scm") (time->seconds "srfi/18.scm") (chain>=? "srfi/67.scm") (integer->list "srfi/60.scm") (test-read-eval-string "srfi/64.scm") (if=? "srfi/67.scm") (fold-ec "srfi/42.scm") (make-date "srfi/19.scm") (time-utc "srfi/19.scm") (test-eqv "srfi/64.scm") (condition-ref "srfi/35.scm") (take-while "srfi/1.scm") (not=? "srfi/67.scm") (append-reverse! "srfi/1.scm") (date-month "srfi/19.scm") (make-s32vector "srfi/4.scm") (mutex "srfi/18.scm") (thread-join! "srfi/18.scm") (test-runner-xpass-count! "srfi/64.scm") (logtest "srfi/60.scm") (list->s64vector "srfi/4.scm") (chain>? "srfi/67.scm") (test-runner-group-stack "srfi/64.scm") (option-optional-arg? "srfi/37.scm") (julian-day->time-monotonic "srfi/19.scm") (<=? "srfi/67.scm") (tdelete-duplicates "srfi/171.scm") (vector-binary-search "srfi/43.scm") (test-runner-create "srfi/64.scm") (caaaar "srfi/1.scm") (condition-variable-specific "srfi/18.scm") (log2-binary-factors "srfi/60.scm") (s64vector-length "srfi/4.scm") (>=/>? "srfi/67.scm") (if<=? "srfi/67.scm") (test-eq "srfi/64.scm") (s8vector "srfi/4.scm") (make-compound-condition "srfi/35.scm") (test-group "srfi/64.scm") (alist-cons "srfi/1.scm") (add-duration! "srfi/19.scm") (logcount "srfi/60.scm") (time-difference! "srfi/19.scm") (date->time-tai "srfi/19.scm") (make-vector "srfi/43.scm") (test-result-alist "srfi/64.scm") (u16vector? "srfi/4.scm") (reverse-bit-field "srfi/60.scm") (values->list "srfi/71.scm") (min-ec "srfi/42.scm") (&condition "srfi/35.scm") (pair-compare-cdr "srfi/67.scm") (drop-right "srfi/1.scm") (test-runner-group-stack! "srfi/64.scm") (thread-name "srfi/18.scm") (open-output-string "srfi/6.scm") (u16vector "srfi/4.scm") (f64vector? "srfi/4.scm") (list-copy "srfi/1.scm") (date? "srfi/19.scm") (caddr "srfi/1.scm") (test-with-runner "srfi/64.scm") (join-timeout-exception? "srfi/18.scm") (cdddar "srfi/1.scm") (list->u8vector "srfi/4.scm") (take-while! "srfi/1.scm") (cond-compare "srfi/67.scm") (map "srfi/1.scm") (pair-for-each "srfi/1.scm") (thread-yield! "srfi/18.scm") (s16vector-ref "srfi/4.scm") (write-with-shared-structure "srfi/38.scm") (tenth "srfi/1.scm") (s8vector-length "srfi/4.scm") (tdrop "srfi/171.scm") (s8vector-set! "srfi/4.scm") (break "srfi/1.scm") (zip "srfi/1.scm") (rotate-bit-field "srfi/60.scm") (make-time "srfi/19.scm") (f32vector? "srfi/4.scm") (u64vector->list "srfi/4.scm") (set-time-nanosecond! "srfi/19.scm") (pairwise-not=? "srfi/67.scm") (seconds->time "srfi/18.scm") (symbol-compare "srfi/67.scm") (test-runner-skip-count! "srfi/64.scm") (time-monotonic->julian-day "srfi/19.scm") (stream-scan "srfi/41.scm") (test-runner? "srfi/64.scm") (test-runner-skip-count "srfi/64.scm") (cut "srfi/26.scm") (span "srfi/1.scm") (cdddr "srfi/1.scm") (tremove "srfi/171.scm") (date-year "srfi/19.scm") (condition-variable-signal! "srfi/18.scm") (test-approximate "srfi/64.scm") (test-runner-xfail-count! "srfi/64.scm") (make-condition "srfi/35.scm") (option-processor "srfi/37.scm") (stream-from "srfi/41.scm") (eager "srfi/45.scm") (map-in-order "srfi/1.scm") (lset-xor "srfi/1.scm") (>/>=? "srfi/67.scm") (ash "srfi/60.scm") (mutex-lock! "srfi/18.scm") (f32vector-set! "srfi/4.scm") (test-runner-current "srfi/64.scm") (lset-intersection "srfi/1.scm") (break! "srfi/1.scm") (drop-while "srfi/1.scm") (time? "srfi/18.scm") (copy-time "srfi/19.scm") (make-thread "srfi/18.scm") (test-match-nth "srfi/64.scm") (assq "srfi/1.scm") (dotted-list? "srfi/1.scm") (stream-lambda "srfi/41.scm") (s16vector->list "srfi/4.scm") (real-compare "srfi/67.scm") (f32vector "srfi/4.scm") (stream-constant "srfi/41.scm") (<=/<=? "srfi/67.scm") (test-runner-pass-count! "srfi/64.scm") (pair-fold "srfi/1.scm") (string-compare-ci "srfi/67.scm") (rational-compare "srfi/67.scm") (copy-bit "srfi/60.scm") (char-compare "srfi/67.scm") (mutex-specific-set! "srfi/18.scm") (stream "srfi/41.scm") (compare-by=/< "srfi/67.scm") (append-map "srfi/1.scm") (make-f64vector "srfi/4.scm") (stream-concat "srfi/41.scm") (null? "srfi/1.scm") (setter "srfi/17.scm") (append! "srfi/1.scm") (time-resolution "srfi/19.scm") (stream-filter "srfi/41.scm") (case-lambda "srfi/16.scm") (append-reverse "srfi/1.scm") (stream-length "srfi/41.scm") (reverse-list->vector "srfi/43.scm") (>=? "srfi/67.scm") (bytevector-u8-transduce "srfi/171.scm") (pair-fold-right "srfi/1.scm") (car "srfi/1.scm") (<? "srfi/67.scm") (list "srfi/1.scm") (force "srfi/45.scm") (stream-append "srfi/41.scm") (make-u8vector "srfi/4.scm") (s32vector "srfi/4.scm") (:list "srfi/42.scm") (lset-difference! "srfi/1.scm") (ninth "srfi/1.scm") (vector-transduce "srfi/171.scm") (time-monotonic->time-utc! "srfi/19.scm") (get-output-string "srfi/6.scm") (cute "srfi/26.scm") (test-runner-get "srfi/64.scm") (booleans->integer "srfi/60.scm") (get-environment-variable "srfi/98.scm") (remove "srfi/1.scm") (null-list? "srfi/1.scm") (string-ref "srfi/17.scm") (test-runner-xpass-count "srfi/64.scm") (test-match-name "srfi/64.scm") (test-on-test-end-simple "srfi/64.scm") (caadr "srfi/1.scm") (f64vector-set! "srfi/4.scm") (promise? "srfi/45.scm") (stream-reverse "srfi/41.scm") (with-exception-handler "srfi/18.scm") (<=/<? "srfi/67.scm") (time-monotonic->date "srfi/19.scm") (test-match-all "srfi/64.scm") (bitwise-not "srfi/60.scm") (time-tai->date "srfi/19.scm") (uncaught-exception? "srfi/18.scm")
    (string-take "srfi/13.scm") (string-ci>= "srfi/13.scm") (string-filter "srfi/13.scm") (string-append/shared "srfi/13.scm") (string<> "srfi/13.scm") (string-ci<= "srfi/13.scm") (string-trim-both "srfi/13.scm") (string-titlecase! "srfi/13.scm") (string-ref "srfi/13.scm") (string-xcopy! "srfi/13.scm") (string-join "srfi/13.scm") (string-map! "srfi/13.scm") (make-string "srfi/13.scm") (string> "srfi/13.scm") (string-delete "srfi/13.scm") (string-index-right "srfi/13.scm") (string-upcase! "srfi/13.scm") (string-map "srfi/13.scm") (string-suffix-ci? "srfi/13.scm") (string-index "srfi/13.scm") (string-length "srfi/13.scm") (string-ci> "srfi/13.scm") (string-contains-ci "srfi/13.scm") (string-suffix-length-ci "srfi/13.scm") (string-ci<> "srfi/13.scm") (string<= "srfi/13.scm") (string= "srfi/13.scm") (string->list "srfi/13.scm") (string-concatenate "srfi/13.scm") (string-hash-ci "srfi/13.scm") (reverse-list->string "srfi/13.scm") (string-downcase "srfi/13.scm") (string-for-each-index "srfi/13.scm") (string-reverse! "srfi/13.scm") (string-concatenate-reverse "srfi/13.scm") (string-drop-right "srfi/13.scm") (string-concatenate-reverse/shared "srfi/13.scm") (string-concatenate/shared "srfi/13.scm") (string-prefix? "srfi/13.scm") (xsubstring "srfi/13.scm") (string-pad "srfi/13.scm") (string "srfi/13.scm") (string-take-right "srfi/13.scm") (string-contains "srfi/13.scm") (string-unfold "srfi/13.scm") (string-prefix-length-ci "srfi/13.scm") (string>= "srfi/13.scm") (string-reverse "srfi/13.scm") (string-fill! "srfi/13.scm") (string-ci< "srfi/13.scm") (string-tokenize "srfi/13.scm") (string-hash "srfi/13.scm") (string-skip "srfi/13.scm") (string? "srfi/13.scm") (string-fold "srfi/13.scm") (string-trim "srfi/13.scm") (string-upcase "srfi/13.scm") (string-trim-right "srfi/13.scm") (string-skip-right "srfi/13.scm") (string-count "srfi/13.scm") (string-append "srfi/13.scm") (string-ci= "srfi/13.scm") (string-every "srfi/13.scm") (string-prefix-ci? "srfi/13.scm") (string-replace "srfi/13.scm") (string-any "srfi/13.scm") (string-downcase! "srfi/13.scm") (string-pad-right "srfi/13.scm") (string-drop "srfi/13.scm") (string-suffix? "srfi/13.scm") (string-suffix-length "srfi/13.scm") (list->string "srfi/13.scm") (string-unfold-right "srfi/13.scm") (string-set! "srfi/13.scm") (string-copy! "srfi/13.scm") (string-for-each "srfi/13.scm") (string-prefix-length "srfi/13.scm") (string-fold-right "srfi/13.scm") (string< "srfi/13.scm") (string-tabulate "srfi/13.scm") (string-copy "srfi/13.scm") (string-titlecase "srfi/13.scm") (substring/shared "srfi/13.scm") (string-compare-ci "srfi/13.scm") (string-compare "srfi/13.scm") (string-null? "srfi/13.scm")
    (char-set-delete! "srfi/14.scm") (char-set-cursor-next "srfi/14.scm") (char-set->list "srfi/14.scm") (char-set->string "srfi/14.scm") (char-set-for-each "srfi/14.scm") (char-set-filter! "srfi/14.scm") (char-set-unfold! "srfi/14.scm") (ucs-range->char-set "srfi/14.scm") (->char-set "srfi/14.scm") (char-set:blank "srfi/14.scm") (char-set-size "srfi/14.scm") (char-set? "srfi/14.scm") (char-set-hash "srfi/14.scm") (char-set:symbol "srfi/14.scm") (char-set:full "srfi/14.scm") (char-set-adjoin "srfi/14.scm") (char-set:letter+digit "srfi/14.scm") (char-set-xor! "srfi/14.scm") (char-set-count "srfi/14.scm") (char-set:title-case "srfi/14.scm") (char-set= "srfi/14.scm") (char-set:letter "srfi/14.scm") (char-set-contains? "srfi/14.scm") (char-set-diff+intersection "srfi/14.scm") (char-set:empty "srfi/14.scm") (char-set:whitespace "srfi/14.scm") (char-set-intersection "srfi/14.scm") (char-set:graphic "srfi/14.scm") (list->char-set! "srfi/14.scm") (list->char-set "srfi/14.scm") (char-set-adjoin! "srfi/14.scm") (char-set-difference "srfi/14.scm") (char-set-intersection! "srfi/14.scm") (char-set-copy "srfi/14.scm") (char-set:lower-case "srfi/14.scm") (char-set-delete "srfi/14.scm") (char-set-any "srfi/14.scm") (string->char-set "srfi/14.scm") (char-set:digit "srfi/14.scm") (char-set:upper-case "srfi/14.scm") (char-set "srfi/14.scm") (char-set-map "srfi/14.scm") (char-set-union "srfi/14.scm") (char-set:printing "srfi/14.scm") (char-set:iso-control "srfi/14.scm") (char-set-unfold "srfi/14.scm") (end-of-char-set? "srfi/14.scm") (char-set-every "srfi/14.scm") (char-set-diff+intersection! "srfi/14.scm") (char-set-complement! "srfi/14.scm") (ucs-range->char-set! "srfi/14.scm") (char-set-cursor "srfi/14.scm") (char-set<= "srfi/14.scm") (char-set-ref "srfi/14.scm") (char-set-xor "srfi/14.scm") (char-set-filter "srfi/14.scm") (char-set-fold "srfi/14.scm") (char-set-difference! "srfi/14.scm") (char-set-union! "srfi/14.scm") (char-set-complement "srfi/14.scm") (char-set:punctuation "srfi/14.scm") (string->char-set! "srfi/14.scm") (char-set:ascii "srfi/14.scm") (char-set:hex-digit "srfi/14.scm")
    ))

(define (make-exports-hashmap r7rs? exports-alist)
  (define H
    (if r7rs?
        (alist->hashmap r7rs-stdlib-exports)
        (make-hashmap)))

  (define (add-export p)
    (define filepath (car p))
    (define exports/dup (cdr p))
    (define exports (list-deduplicate/reverse exports/dup))

    (unless (= (length exports)
               (length exports/dup))
      (warn "File ~s exports same variables multiple times" filepath))

    (for-each
     (lambda (exp)
       (define get (hashmap-ref H exp '()))
       (hashmap-set! H exp (cons filepath get)))
     exports))

  (for-each add-export exports-alist)

  (hashmap-foreach
   (lambda (key val)
     ;; (hashmap-delete! H key)
     (hashmap-set! H key (car val))
     (unless (list-singleton? val)
       (warn "Name ~s exported from multiple files: ~a"
             (~a key) (words->string val))))
   H)

  H)

(define (try-read-symlink path)
  (catch-any
   (lambda _ (readlink path))
   (lambda _ #f)))

(define (is-file-a-symlink? path)
  (catch-any
   (lambda _ (try-read-symlink path) #t)
   (lambda _ #f)))

(define (same-files? a-path b-path)
  (equal? (get-true-path a-path)
          (get-true-path b-path)))

(define (get-true-path1 path)
  (path-normalize (or (try-read-symlink path) path)))

(define (get-true-path path)
  (define parts (string-split/simple path #\/))

  (define new-parts
    (let loop ((parts parts))
      (if (null? parts) '()
          (let ((head (car parts)))
            (cons (get-true-path1 head)
                  (loop (cdr parts)))))))

  (define joined
    (path-normalize
     (apply
      string-append
      (list-intersperse "/" new-parts))))

  (if (absolute-posix-path? path)
      (string-append "/" joined)
      joined))

(define (find-all-files . dirs)
  (define-pair (text status)
    (apply
     system-re
     (cons
      (string-append
       "find -L"
       (words->string (replicate (length dirs) " ~a "))
       "-maxdepth 5 -type f")
      dirs)))
  (filter (negate string-null-or-whitespace?)
          (string->lines text)))

(define (collect-imports --import-everything export-maps symbols)
  (define H (make-hashmap))
  (define limiter
    (if --import-everything
        (map car (hashmap->alist export-maps))
        symbols))

  (for-each
   (lambda (sym)
     (define source (hashmap-ref export-maps sym #f))
     (when source
       (let ((existing (hashmap-ref H source '())))
         (hashmap-set! H source (cons sym existing)))))
   limiter)

  H)

(define (split-by-fun fun lines yes no)
  (define-values (head rem)
    (list-span-while fun lines))

  (if (not (null? rem))
      (yes head rem)
      (no)))

(define-syntax split-by-fun*
  (syntax-rules (split)
    ((_)
     (lambda (lines)
       (raisu (fatal "failed to split the code"))))
    ((_ (split fun yes) . bodies)
     (lambda (lines)
       (split-by-fun fun lines yes
                     (lambda ()
                       ((split-by-fun* . bodies) lines)))))))

(define (read/lines/first predicate path)
  (define p (if (port? path) path (open path O_RDONLY)))
  (define ret
    (let loop ()
      (define line (read-line p))
      (cond
       ((eof-object? line) #f)
       ((predicate line) line)
       (else (loop)))))
  (when (string? path)
    (close-port p))
  ret)

(define (guile-line-is-var? line)
  (define s (string-strip line))
  (or (string-prefix? ":export" s)
      (string-prefix? ":re-export" s)
      (string-prefix? "#:export" s)
      (string-prefix? "#:re-export" s)
      (string-prefix? "#:export" s)
      (string-prefix? ":re-export-syntax" s)
      (string-prefix? "#:re-export-syntax" s)
      ))

(define (guile-file-get-exports filepath)
  (define decl/sexp (file-read-first-expression filepath))
  (guile-decl-get-exports decl/sexp))

(define (guile-decl-get-exports decl/sexp)
  (define module (get-guile-module decl/sexp))
  (if module
      (guile-module-definition-exports module)
      '()))

(define (guile-main --import-everything <filepath>)
  (define original-lines/0 (read/lines <filepath>))

  (define (import->use-line prefix import)
    (define-pair (import-path import-names) import)
    (define path-parts/0 (string-split/simple (car import) #\/))
    (define path-parts/1 (filter (negate (compose-under or string-null? (comp (equal? "."))))
                                 path-parts/0))
    (define last-part (path-without-extension (list-last path-parts/1)))
    (define module-path/1 (append (list-init path-parts/1) (list last-part)))
    (define module-path (map string->symbol module-path/1))

    (string-append
     prefix
     ":use-module "
     (~a
      (list
       module-path
       ':select
       (sort (map symbol->string import-names) string<?)))))

  (define (get-uselines-prefix original-lines)
    (define use-lines (filter line-is-use? original-lines))
    (if (null? use-lines) ""
        (let ()
          (define chars (string->list (car use-lines)))
          (define taken (list-take-while (lambda (c) (member c '(#\space #\tab #\return #\page #\linefeed))) chars))
          (list->string taken))))

  (define (path-length path)
    (length
     (filter (comp (equal? #\/))
             (string->list path))))

  (define (import-length p)
    (define path (car p))
    (path-length path))

  (define (collected->use-lines prefix collected-hashmap)
    (define alist/unsorted (hashmap->alist collected-hashmap))
    (define alist
      (sort alist/unsorted
            (lambda (a b)
              (let ((al (import-length a))
                    (bl (import-length b)))
                (cond
                 ((< al bl) #f)
                 ((> al bl) #t)
                 (else
                  (string<? (car a) (car b))))))))

    (map (comp (import->use-line prefix)) alist))

  (define (line-is-use? line)
    (string-prefix? ":use-module" (string-strip line)))

  (define (line-is-empty? line)
    (define-values (text comm commendted)
      (string-split-3 #\; line))

    (string-null-or-whitespace? text))

  (define split-header
    (split-by-fun*
     (split (negate line-is-use?)
            (lambda (head rem)
              (values head rem)))
     (split (compose-under or line-is-empty? guile-line-is-var?)
            (lambda (head rem)
              (values head (cons "" rem))))))

  (define (split-use-block after-header)
    (define-values (first-use-block0 remaining-lines0)
      (list-span-while
       (compose-under or line-is-use? line-is-empty?)
       after-header))

    (define-values (empty-lines/rev first-use-block/rev)
      (list-span-while line-is-empty? (reverse first-use-block0)))

    (define empty-lines
      (reverse empty-lines/rev))

    (define first-use-block
      (reverse first-use-block/rev))

    (define remaining-lines
      (append empty-lines remaining-lines0))

    (values first-use-block remaining-lines))

  (define (try-parse-text-without-use-lines text)
    (catch-any
     (lambda _
       (with-input-from-string text (lambda _ (read-list))))
     (lambda errors
       (dprintln "Could not remove the :use-module lines, make sure that each :use-module does not end with extra closing parens")
       (exit 1))))

  (define (get-import-root-dir fullname lines)
    (define module-definition-line
      (list-find-first
       (lambda (line)
         (string-prefix? "(define-module" (string-strip line)))
       (begin
         (dprintln "Could not find (define-module) line. Need it to infer the root directory")
         (exit 1))
       lines))

    (define module-definition
      (with-input-from-string
          (substring (string-strip module-definition-line) 1)
        (lambda _
          (read) ;; the 'define-module keyword
          (read) ;; module identifier
          )))

    (define root
      (path-normalize
       (apply
        append-posix-path
        (cons fullname (replicate (length module-definition) "..")))))

    root)

  (define (fix-use-line-brackets prefix use-line)
    (define chars (string->list use-line))
    (define new-lines
      (let loop ((opened-count 0)
                 (left chars)
                 (buf '()))
        (if (null? left)
            (list use-line)
            (let ((c (car left)))
              (cond
               ((equal? #\( c)
                (loop (+ opened-count 1) (cdr left) (cons c buf)))
               ((equal? #\) c)
                (if (equal? opened-count 0)
                    (list (list->string (reverse buf)) (string-append prefix (list->string left)))
                    (loop (- opened-count 1) (cdr left) (cons c buf))))
               (else (loop opened-count (cdr left) (cons c buf))))))))

    new-lines)

  (define (fix-use-lines prefix original-lines)
    (apply
     append
     (map
      (lambda (line)
        (if (line-is-use? line)
            (fix-use-line-brackets prefix line)
            (list line)))
      original-lines)))


  (let* ((fullname (if (absolute-posix-path? <filepath>) <filepath> (append-posix-path (get-current-directory) <filepath>)))
         (uselines-prefix (get-uselines-prefix original-lines/0))
         (original-lines (fix-use-lines uselines-prefix (read/lines fullname)))
         (import-root-dir (get-import-root-dir fullname original-lines))
         (do (chdir import-root-dir))
         (lines-without-use-lines (filter (negate line-is-use?) original-lines))
         (text-without-use-lines (lines->string lines-without-use-lines))
         (parsed (try-parse-text-without-use-lines text-without-use-lines))
         (this-exports (guile-file-get-exports fullname))
         (symbols/dup (fully-flatten parsed))
         (symbols/with-this (list-deduplicate/reverse symbols/dup))
         (symbols (filter (lambda (x) (not (member x this-exports))) symbols/with-this))
         (files/dup (find-all-files "."))
         (files/grouped (map cdr (list-group-by get-true-path files/dup)))
         (files (list-deduplicate/reverse (map (comp (list-minimal-element-or/proj #f string-length <)) files/grouped)))
         (export-alist (map (compose-under cons identity file-get-exports) files))
         (export-maps (make-exports-hashmap #f export-alist))
         (collected (collect-imports --import-everything export-maps symbols))
         (use-lines (collected->use-lines uselines-prefix collected)))

    (define-values (header after-header)
      (split-header original-lines))

    (define-values (first-use-block remaining-lines)
      (split-use-block after-header))

    (define new-lines
      (append header
              use-lines
              remaining-lines
              '("")))

    (define new-text
      (lines->string new-lines))

    (unless (and (null? first-use-block)
                 (null? use-lines))
      (write-string-file fullname new-text))

    (dprintln "Done (Guile)")

    ))

(define-type9 <r7rsdecl>
  (make-r7rsdecl keyword signature exports imports other) r7rsdecl?
  (keyword r7rsdecl-keyword)
  (signature r7rsdecl-signature)
  (exports r7rsdecl-exports)
  (imports r7rsdecl-imports)
  (other r7rsdecl-other)
  ;; there may be other fields
  )

(define (is-r7rsdecl-export? p)
  (and (pair? p) (equal? (car p) 'export)))

(define (is-r7rsdecl-import? p)
  (and (pair? p)
       (or (equal? (car p) 'import)
           (and (equal? (car p) 'cond-expand)
                (list-and-map
                 (lambda (clause)
                   (define bodies (cdr clause))
                   (and (pair? bodies)
                        ;; (list-singleton? bodies)
                        (equal? 'import (car bodies))))
                 (cdr p))))))

(define (parse-r7rsdecl x)
  (make-r7rsdecl
   (list-ref x 0)
   (list-ref x 1)
   (apply
    append
    (map
     cdr
     (filter is-r7rsdecl-export? x)))
   (map
    cdr
    (filter is-r7rsdecl-import? x))
   (filter
    (negate
     (compose-under
      or is-r7rsdecl-export? is-r7rsdecl-import?))
    (list-drop-n 2 x))
   ))

(define (display-r7rsdecl x)
  (newline)
  (pretty-print
   (append
    (list (r7rsdecl-keyword x))
    (list (r7rsdecl-signature x))
    (if (null? (r7rsdecl-exports x))
        '()
        (list (cons 'export (r7rsdecl-exports x))))
    (if (null? (r7rsdecl-imports x))
        '()
        (r7rsdecl-imports x))
    (r7rsdecl-other x))))

(define (is-r7rsdecl-decl? decl/sexp)
  (and (pair? decl/sexp)
       (equal? 'define-library (car decl/sexp))))

(define (r7rsdecl-get-exports decl/sexp)
  (define decl (parse-r7rsdecl decl/sexp))
  (r7rsdecl-exports decl))

(define (file-get-exports filepath)
  (define decl/sexp (file-read-first-expression filepath))
  (cond
   ((is-guile-decl? decl/sexp)
    (guile-decl-get-exports decl/sexp))
   ((is-r7rsdecl-decl? decl/sexp)
    (r7rsdecl-get-exports decl/sexp))
   (else (list))))

(define (r7rs-read-declaration <filepath> sld-fullname)
  (define _1
    (unless (file-or-directory-exists? sld-fullname)
      (fatal "Expected a scheme declaration file for ~s" <filepath>)))

  (define p (open-file sld-fullname "r"))
  (define decl/sexp (read p))
  (close-port p)
  (parse-r7rsdecl decl/sexp))

(define (r7rs-main --import-everything <filepath> decl/sexp/0)
  (define decl/sexp (or decl/sexp/0 (file-read-first-expression <filepath>)))

  (define fullname/0
    (if (absolute-posix-path? <filepath>) <filepath> (append-posix-path (get-current-directory) <filepath>)))

  (define-values (fullname sld-fullname decl)
    (if (string-suffix? ".sld" fullname/0)
        (let ((sld (path-replace-extension fullname/0 ".scm")))
          (unless (file-or-directory-exists? sld)
            (fatal "Expected ~s file to exist." sld))

          (values
           sld
           fullname/0
           (parse-r7rsdecl decl/sexp)
           ))
        (values
         fullname/0
         (path-replace-extension fullname/0 ".sld")
         (r7rs-read-declaration <filepath> (path-replace-extension fullname/0 ".sld"))
         )))

  (r7rs-main/do --import-everything fullname sld-fullname decl))

(define (r7rs-main/do --import-everything fullname sld-fullname decl)
  (define (collected->use-lines collected-hashmap)
    (define alist/unsorted (hashmap->alist collected-hashmap))
    (define alist
      (sort alist/unsorted
            (lambda (a b)
              (let ((al (import-length a))
                    (bl (import-length b)))
                (cond
                 ((< al bl) #f)
                 ((> al bl) #t)
                 (else
                  (string<? (car a) (car b))))))))

    (map import->use-line alist))

  (define (make-default-use-line module-path sorted-names)
    `(import (only ,module-path ,@sorted-names)))

  (define (make-srfi-use-line module-path sorted-names)
    (define _check
      (unless (equal? 2 (length module-path))
        (raisu 'weird-srfi-module-path module-path)))

    (define guile-module-path
      (list (car module-path)
            (string->symbol
             (string-append
              "srfi-" (~a (cadr module-path))))))

    `(cond-expand
      (guile (import (only ,guile-module-path ,@sorted-names)))
      (else (import (only ,module-path ,@sorted-names)))))

  (define (import->use-line import)
    (define-pair (import-path import-names) import)
    (define path-parts/0 (string-split/simple (car import) #\/))
    (define path-parts/1 (filter (negate (compose-under or string-null? (comp (equal? "."))))
                                 path-parts/0))
    (define last-part (path-without-extension (list-last path-parts/1)))
    (define module-path/1 (append (list-init path-parts/1) (list last-part)))
    (define module-path
      (map (compose-under or string->number string->symbol) module-path/1))
    (define sorted-names
      (sort import-names
            (lambda (a b)
              (string<? (symbol->string a)
                        (symbol->string b)))))

    (if (equal? 'srfi (car module-path))
        (make-srfi-use-line module-path sorted-names)
        (make-default-use-line module-path sorted-names)))

  (define (path-length path)
    (length
     (filter (comp (equal? #\/))
             (string->list path))))

  (define (import-length p)
    (define path (car p))
    (path-length path))

  (define (get-import-root-dir fullname decl)
    (define module-definition
      (r7rsdecl-signature decl))

    (define root
      (path-normalize
       (apply
        append-posix-path
        (cons fullname (replicate (length module-definition) "..")))))

    root)

  (let* ((import-root-dir (get-import-root-dir fullname decl))
         (do (chdir import-root-dir))
         (this-exports (r7rsdecl-exports decl))
         (parsed (with-input-from-file fullname (lambda _ (read-list))))
         (symbols/dup (cons 'begin (fully-flatten parsed)))
         (symbols/with-this (list-deduplicate/reverse symbols/dup))
         (symbols (filter (lambda (x) (not (memq x this-exports))) symbols/with-this))
         (files/dup (find-all-files "."))
         (files/grouped (map cdr (list-group-by get-true-path files/dup)))
         (files (list-deduplicate/reverse (map (comp (list-minimal-element-or/proj #f string-length <)) files/grouped)))
         (export-alist (map (compose-under cons identity file-get-exports) files))
         (export-maps (make-exports-hashmap #t export-alist))
         (collected (collect-imports --import-everything export-maps symbols))
         (use-lines (collected->use-lines collected)))

    (define new-decl
      (make-r7rsdecl
       (r7rsdecl-keyword decl)
       (r7rsdecl-signature decl)
       (r7rsdecl-exports decl)
       use-lines
       (r7rsdecl-other decl)
       ))

    (define new-text
      (with-output-to-string
        (lambda _
          (display-r7rsdecl new-decl))))

    (write-string-file sld-fullname new-text)

    (dprintln "Done (r7rs)")

    ))

(define (is-guile-module-definition? decl/sexp)
  (and (pair? decl/sexp)
       (equal? 'define-module (car decl/sexp))
       (pair? (cdr decl/sexp))))

(define (get-guile-module decl/sexp)
  (if (is-guile-module-definition? decl/sexp)
      decl/sexp
      (and (pair? decl/sexp)
           (equal? 'cond-expand (car decl/sexp))
           (list? (cdr decl/sexp))
           (list-and-map list? (cdr decl/sexp))
           (let* ((alts (cdr decl/sexp))
                  (guiles
                   (or
                    (assq-or 'guile alts)
                    (assq-or 'guile2 alts)
                    (assq-or 'guile3 alts))))
             (and guiles
                  (pair? guiles)
                  (list-find-first
                   is-guile-module-definition?
                   #f guiles))))))

(define (is-guile-decl? decl/sexp)
  (get-guile-module decl/sexp))

(define (guile-module-definition-exports guile-module)
  (define (maybe-unpack-pair p)
    (if (pair? p)
        (cdr p)
        p))

  (unless (is-guile-module-definition? guile-module)
    (raisu 'not-a-guile-module-definiton guile-module))

  (map
   maybe-unpack-pair
   (apply
    append
    (let loop ((first (list-ref guile-module 0))
               (second (list-ref guile-module 1))
               (rest (list-drop-n 2 guile-module)))
      (define (next)
        (if (null? rest) '()
            (loop second (car rest) (cdr rest))))

      (if (memq first '(:export #:export
                        :export-syntax #:export-syntax
                        :re-export #:re-export
                        :re-export-syntax #:re-export-syntax
                        :re-export-and-replace #:re-export-and-replace
                        :re-export-replacements #:re-export-replacements
                        :replace #:replace
                        ))
          (cons second (next))
          (next))))))

(define (file-read-first-expression <filepath>)
  (define p (open-file <filepath> "r"))
  (define first
    (catch-any
     (lambda _ (read p))
     (lambda _ #f)))
  (close-port p)
  first)

(define (is-guile-file? <filepath>)
  (define first (file-read-first-expression <filepath>))
  (is-guile-decl? first))

(define (do-initialize-stdlib-exports <root> <files...>*)
  (define _1 (chdir <root>))
  (define files/dup <files...>*)
  (define files/grouped (map cdr (list-group-by get-true-path files/dup)))
  (define files
    (list-deduplicate/reverse (map (comp (list-minimal-element-or/proj #f string-length <)) files/grouped)))
  (define (remove-prefix path)
    (remove-common-prefix path <root>))
  (define export-alist
    (map (compose-under cons remove-prefix file-get-exports) files))
  (define export-h
    (make-exports-hashmap #f export-alist))
  (define export-alist/dedup
    (map (fn-pair (a b) (list a b))
         (hashmap->alist export-h)))

  (write export-alist/dedup)
  (newline))
