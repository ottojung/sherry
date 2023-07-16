
(define-library
  (sherry file-neighbours)
  (export file-neighbours)
  (import
    (only (euphrates directory-files)
          directory-files))
  (import
    (only (euphrates path-get-dirname)
          path-get-dirname))
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (scheme base) begin car define lambda map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/file-neighbours.scm")))
    (else (include "file-neighbours.scm"))))
