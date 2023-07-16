
(define-library
  (sherry is-r7rs-source-file-huh)
  (export is-r7rs-source-file?)
  (import
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?))
  (import
    (only (euphrates path-replace-extension)
          path-replace-extension))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/is-r7rs-source-file-huh.scm")))
    (else (include "is-r7rs-source-file-huh.scm"))))
