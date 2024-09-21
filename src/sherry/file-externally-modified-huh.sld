
(define-library
  (sherry file-externally-modified-huh)
  (export file:externally-modified?)
  (import (only (euphrates file-mtime) file-mtime))
  (import
    (only (sherry file-modification-time)
          file:modification-time))
  (import
    (only (scheme base) begin define equal? if))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-externally-modified-huh.scm")))
    (else (include "file-externally-modified-huh.scm"))))
