
(define-library
  (sherry shebang-line-huh)
  (export shebang-line?)
  (import
    (only (euphrates irregex)
          irregex-match
          sre->irregex))
  (import
    (only (scheme base)
          *
          begin
          define
          lambda
          let
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/shebang-line-huh.scm")))
    (else (include "shebang-line-huh.scm"))))
