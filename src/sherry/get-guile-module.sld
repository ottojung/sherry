
(define-library
  (sherry get-guile-module)
  (export get-guile-module)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (sherry is-guile-module-definition-huh)
          is-guile-module-definition?))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond-expand
          define
          equal?
          if
          let*
          list?
          or
          pair?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/get-guile-module.scm")))
    (else (include "get-guile-module.scm"))))
