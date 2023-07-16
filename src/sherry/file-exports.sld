
(define-library
  (sherry file-exports)
  (export file-exports)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (sherry file-first-expression)
          file-first-expression))
  (import
    (only (sherry file-source-type) file-source-type))
  (import
    (only (sherry guile-decl-get-exports)
          guile-decl-get-exports))
  (import
    (only (sherry is-guile-decl-huh) is-guile-decl?))
  (import
    (only (sherry is-r7rsdecl-decl-huh)
          is-r7rsdecl-decl?))
  (import
    (only (sherry r7rsdecl-get-exports)
          r7rsdecl-get-exports))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          lambda
          list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/file-exports.scm")))
    (else (include "file-exports.scm"))))
