
(define-library
  (sherry is-r7rsdecl-export-huh)
  (export is-r7rsdecl-export?)
  (import
    (only (scheme base)
          and
          begin
          car
          define
          equal?
          pair?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/is-r7rsdecl-export-huh.scm")))
    (else (include "is-r7rsdecl-export-huh.scm"))))
