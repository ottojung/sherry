
(define-library
  (sherry file-modification-time-update-bang)
  (export file:modification-time:update!)
  (import
    (only (euphrates properties) set-property!))
  (import
    (only (sherry file-externally-modified-huh)
          file:externally-modified?))
  (import
    (only (sherry file-modification-time)
          file:modification-time))
  (import (only (scheme base) begin define when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-modification-time-update-bang.scm")))
    (else (include
            "file-modification-time-update-bang.scm"))))
