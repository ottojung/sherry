
(define-library
  (sherry is-guile-module-definition-huh)
  (export is-guile-module-definition?)
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          define
          equal?
          pair?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/is-guile-module-definition-huh.scm")))
    (else (include "is-guile-module-definition-huh.scm"))))
