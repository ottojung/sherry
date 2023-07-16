
(define-library
  (sherry file-first-expression)
  (export file-first-expression)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (sherry file-read-first-expression)
          file-read-first-expression))
  (import (only (scheme base) begin lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-first-expression.scm")))
    (else (include "file-first-expression.scm"))))
