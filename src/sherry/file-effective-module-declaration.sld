
(define-library
  (sherry file-effective-module-declaration)
  (export file-effective-module-declaration)
  (import
    (only (euphrates path-replace-extension)
          path-replace-extension))
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import (only (euphrates raisu) raisu))
  (import
    (only (sherry file-module-declaration)
          file-module-declaration))
  (import
    (only (sherry file-source-type) file-source-type))
  (import
    (only (scheme base)
          begin
          cond
          cond-expand
          define
          else
          equal?
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-effective-module-declaration.scm")))
    (else (include "file-effective-module-declaration.scm"))))
