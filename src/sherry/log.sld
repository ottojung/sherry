
(define-library
  (sherry log)
  (export log-info log-error)
  (import (only (euphrates dprintln) dprintln))
  (import
    (only (scheme base)
          apply
          begin
          cons
          current-error-port
          current-output-port
          define
          parameterize))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "sherry/log.scm")))
    (else (include "log.scm"))))
