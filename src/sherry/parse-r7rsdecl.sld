
(define-library
  (sherry parse-r7rsdecl)
  (export parse-r7rsdecl)
  (import
    (only (euphrates compose-under) compose-under))
  (import
    (only (euphrates list-drop-n) list-drop-n))
  (import (only (euphrates negate) negate))
  (import
    (only (sherry is-r7rsdecl-export-huh)
          is-r7rsdecl-export?))
  (import
    (only (sherry is-r7rsdecl-import-huh)
          is-r7rsdecl-import?))
  (import (only (sherry r7rsdecl) make-r7rsdecl))
  (import
    (only (scheme base)
          append
          apply
          begin
          cdr
          define
          list-ref
          map
          or))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/parse-r7rsdecl.scm")))
    (else (include "parse-r7rsdecl.scm"))))
