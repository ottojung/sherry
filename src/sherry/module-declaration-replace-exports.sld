
(define-library
  (sherry module-declaration-replace-exports)
  (export module-declaration-replace-exports)
  (import (only (euphrates raisu) raisu))
  (import
    (only (sherry is-guile-decl-huh) is-guile-decl?))
  (import
    (only (sherry is-r7rsdecl-decl-huh)
          is-r7rsdecl-decl?))
  (import
    (only (scheme base)
          begin
          cadr
          car
          cdr
          cond
          cond-expand
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
    (guile (import (only (srfi srfi-35) condition)))
    (else (import (only (srfi 35) condition))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/module-declaration-replace-exports.scm")))
    (else (include
            "module-declaration-replace-exports.scm"))))
