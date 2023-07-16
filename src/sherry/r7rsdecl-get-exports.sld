
(define-library
  (sherry r7rsdecl-get-exports)
  (export r7rsdecl-get-exports)
  (import
    (only (sherry parse-r7rsdecl) parse-r7rsdecl))
  (import
    (only (sherry r7rsdecl) r7rsdecl-exports))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/r7rsdecl-get-exports.scm")))
    (else (include "r7rsdecl-get-exports.scm"))))
