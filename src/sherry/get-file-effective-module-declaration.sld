
(define-library
  (sherry get-file-effective-module-declaration)
  (export get-file-effective-module-declaration)
  (import
    (only (sherry file-effective-module-declaration)
          file-effective-module-declaration))
  (import
    (only (sherry pretty-print) pretty-print))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          newline))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/get-file-effective-module-declaration.scm")))
    (else (include
            "get-file-effective-module-declaration.scm"))))
