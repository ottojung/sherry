
(define-library
  (sherry is-guile-file-huh)
  (export is-guile-file?)
  (import
    (only (sherry file-first-expression)
          file-first-expression))
  (import
    (only (sherry is-guile-decl-huh) is-guile-decl?))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/is-guile-file-huh.scm")))
    (else (include "is-guile-file-huh.scm"))))
