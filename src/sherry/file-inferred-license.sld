
(define-library
  (sherry file-inferred-license)
  (export file-inferred-license)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (sherry infer-file-license)
          infer-file-license))
  (import (only (scheme base) begin lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-inferred-license.scm")))
    (else (include "file-inferred-license.scm"))))
