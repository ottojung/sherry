
(define-library
  (sherry file-source-type)
  (export file-source-type)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (sherry is-guile-file-huh) is-guile-file?))
  (import
    (only (sherry is-r7rs-library-file-huh)
          is-r7rs-library-file?))
  (import
    (only (sherry is-r7rs-program-file-huh)
          is-r7rs-program-file?))
  (import
    (only (sherry is-r7rs-source-file-huh)
          is-r7rs-source-file?))
  (import
    (only (scheme base) begin cond else lambda quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/file-source-type.scm")))
    (else (include "file-source-type.scm"))))
