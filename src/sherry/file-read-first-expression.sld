
(define-library
  (sherry file-read-first-expression)
  (export file-read-first-expression)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (scheme base) _ begin define lambda))
  (import
    (only (scheme file) call-with-input-file))
  (import (only (scheme read) read))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-read-first-expression.scm")))
    (else (include "file-read-first-expression.scm"))))
