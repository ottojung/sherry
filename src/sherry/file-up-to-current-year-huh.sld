
(define-library
  (sherry file-license-up-to-current-year-huh)
  (export file-license-up-to-current-year?)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (sherry file-modification-years)
          file-modification-years))
  (import
    (only (sherry get-current-year) get-current-year))
  (import
    (only (sherry year-in-years-huh) year-in-years?))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-license-up-to-current-year-huh.scm")))
    (else (include "file-up-to-current-year-huh.scm"))))
