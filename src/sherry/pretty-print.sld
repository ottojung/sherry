
(define-library
  (sherry pretty-print)
  (export pretty-print)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (rename
               (ice-9 pretty-print)
               (pretty-print system-pp)))
           (begin
             (include-from-path "sherry/pretty-print.scm")))
    (else (include "pretty-print.scm"))))
