
(define-library
  (sherry get-file-dependencies)
  (export get-file-dependencies/print)
  (import
    (only (scheme base) begin define newline))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/get-file-dependencies.scm")))
    (else (include "get-file-dependencies.scm"))))
