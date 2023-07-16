
(define-library
  (sherry get-current-year)
  (export get-current-year)
  (import
    (only (euphrates date-get-current-string)
          date-get-current-string))
  (import
    (only (scheme base) begin define string->number))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/get-current-year.scm")))
    (else (include "get-current-year.scm"))))
