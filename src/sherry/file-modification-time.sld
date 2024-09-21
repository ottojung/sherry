
(define-library
  (sherry file-modification-time)
  (export file:modification-time)
  (import (only (euphrates file-mtime) file-mtime))
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import (only (scheme base) begin lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-modification-time.scm")))
    (else (include "file-modification-time.scm"))))
