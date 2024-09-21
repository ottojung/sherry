
(define-library
  (sherry watch-file)
  (export watch-file)
  (import
    (only (sherry fix-imports-generic)
          fix-imports/generic))
  (import
    (only (scheme base) begin define newline))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/watch-file.scm")))
    (else (include "watch-file.scm"))))
