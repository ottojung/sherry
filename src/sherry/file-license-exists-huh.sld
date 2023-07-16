
(define-library
  (sherry file-license-exists-huh)
  (export file-license-exists?)
  (import
    (only (sherry licensedfile) file-license))
  (import (only (scheme base) begin define not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/file-license-exists-huh.scm")))
    (else (include "file-license-exists-huh.scm"))))
