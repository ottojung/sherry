
(define-library
  (sherry module-declaration-replace-name)
  (export module-declaration-replace-name)
  (import
    (only (euphrates irregex) irregex-replace/all))
  (import (only (euphrates list-last) list-last))
  (import
    (only (euphrates list-replace-last)
          list-replace-last))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          cadr
          car
          cddr
          cdr
          cond
          cons
          define
          else
          equal?
          let
          list
          or
          pair?
          quote
          string?))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/module-declaration-replace-name.scm")))
    (else (include "module-declaration-replace-name.scm"))))
