
(define-library
  (sherry module-declaration-replace-exports)
  (export module-declaration-replace-exports)
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          if
          lambda
          let
          list
          map
          null?
          or
          pair?
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/module-declaration-replace-exports.scm")))
    (else (include
            "module-declaration-replace-exports.scm"))))
