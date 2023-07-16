
(define-library
  (sherry file-modification-years)
  (export file-modification-years)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (sherry get-file-modification-years)
          get-file-modification-years))
  (import (only (scheme base) begin lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-modification-years.scm")))
    (else (include "file-modification-years.scm"))))
