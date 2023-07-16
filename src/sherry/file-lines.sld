
(define-library
  (sherry file-lines)
  (export file-lines)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (euphrates string-to-lines) string->lines))
  (import (only (sherry file-text) file-text))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/file-lines.scm")))
    (else (include "file-lines.scm"))))
