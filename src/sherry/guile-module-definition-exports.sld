
(define-library
  (sherry guile-module-definition-exports)
  (export guile-module-definition-exports)
  (import
    (only (euphrates list-drop-n) list-drop-n))
  (import (only (euphrates raisu) raisu))
  (import
    (only (sherry is-guile-module-definition-huh)
          is-guile-module-definition?))
  (import
    (only (scheme base)
          append
          apply
          begin
          car
          cdr
          cons
          define
          if
          let
          list-ref
          map
          memq
          null?
          pair?
          quote
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-1) first second)))
    (else (import (only (srfi 1) first second))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/guile-module-definition-exports.scm")))
    (else (include "guile-module-definition-exports.scm"))))
