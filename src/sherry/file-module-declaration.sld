
(define-library
  (sherry file-module-declaration)
  (export file-module-declaration)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import (only (euphrates raisu) raisu))
  (import
    (only (sherry file-first-expression)
          file-first-expression))
  (import
    (only (sherry file-source-type) file-source-type))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-module-declaration.scm")))
    (else (include "file-module-declaration.scm"))))
