
(define-library
  (sherry guile-decl-get-exports)
  (export guile-decl-get-exports)
  (import
    (only (sherry get-guile-module) get-guile-module))
  (import
    (only (sherry guile-module-definition-exports)
          guile-module-definition-exports))
  (import
    (only (scheme base) begin define if quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/guile-decl-get-exports.scm")))
    (else (include "guile-decl-get-exports.scm"))))
