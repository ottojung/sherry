
(define-library
  (sherry get-file-exports)
  (export get-file-exports/print)
  (import
    (only (sherry file-exports) file-exports))
  (import
    (only (scheme base) begin define newline))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/get-file-exports.scm")))
    (else (include "get-file-exports.scm"))))
