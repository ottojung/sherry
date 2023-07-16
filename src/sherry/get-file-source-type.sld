
(define-library
  (sherry get-file-source-type)
  (export get-file-source-type/print)
  (import
    (only (sherry file-source-type) file-source-type))
  (import
    (only (scheme base) begin define newline))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/get-file-source-type.scm")))
    (else (include "get-file-source-type.scm"))))
