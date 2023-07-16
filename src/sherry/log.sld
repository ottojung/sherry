
(define-library
  (sherry log)
  (export log-info log-error)
  (import (only (euphrates dprintln) dprintln))
  (import (only (euphrates raisu) raisu))
  (import (only (sherry log-level-p) log-level/p))
  (import
    (only (scheme base)
          apply
          begin
          cond
          cons
          current-error-port
          current-output-port
          define
          else
          equal?
          parameterize
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "sherry/log.scm")))
    (else (include "log.scm"))))
