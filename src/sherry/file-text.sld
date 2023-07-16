
(define-library
  (sherry file-text)
  (export file-text)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import (only (scheme base) begin lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/file-text.scm")))
    (else (include "file-text.scm"))))
