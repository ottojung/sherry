
(define-library
  (sherry fix-imports-generic)
  (export fix-imports/generic)
  (import
    (only (sherry file-read-first-expression)
          file-read-first-expression))
  (import
    (only (sherry is-guile-decl-huh) is-guile-decl?))
  (import
    (only (sherry scheme-imports)
          czempak-main
          guile-main
          r7rs-main))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/fix-imports-generic.scm")))
    (else (include "fix-imports-generic.scm"))))
