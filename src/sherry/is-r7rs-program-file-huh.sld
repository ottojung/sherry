
(define-library
  (sherry is-r7rs-program-file-huh)
  (export is-r7rs-program-file?)
  (import
    (only (sherry file-first-expression)
          file-first-expression))
  (import
    (only (scheme base)
          and
          begin
          car
          define
          equal?
          let
          list?
          pair?
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/is-r7rs-program-file-huh.scm")))
    (else (include "is-r7rs-program-file-huh.scm"))))
