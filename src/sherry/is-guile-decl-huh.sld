
(define-library
  (sherry is-guile-decl-huh)
  (export is-guile-decl?)
  (import
    (only (sherry get-guile-module) get-guile-module))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/is-guile-decl-huh.scm")))
    (else (include "is-guile-decl-huh.scm"))))
