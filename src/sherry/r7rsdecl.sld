
(define-library
  (sherry r7rsdecl)
  (export
    make-r7rsdecl
    r7rsdecl-keyword
    r7rsdecl-signature
    r7rsdecl-exports
    r7rsdecl-imports
    r7rsdecl-other)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "sherry/r7rsdecl.scm")))
    (else (include "r7rsdecl.scm"))))
