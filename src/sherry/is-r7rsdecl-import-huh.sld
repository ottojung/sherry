
(define-library
  (sherry is-r7rsdecl-import-huh)
  (export is-r7rsdecl-import?)
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond-expand
          define
          equal?
          lambda
          or
          pair?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/is-r7rsdecl-import-huh.scm")))
    (else (include "is-r7rsdecl-import-huh.scm"))))
