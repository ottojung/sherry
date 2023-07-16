
(define-library
  (sherry log-level-p)
  (export log-level/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/log-level-p.scm")))
    (else (include "log-level-p.scm"))))
