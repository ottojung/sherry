
(define-library
  (sherry export-name-to-file-name)
  (export export-name->file-name)
  (import (only (euphrates comp) appcomp))
  (import
    (only (euphrates irregex)
          irregex-replace
          irregex-replace/all))
  (import
    (only (scheme base) + begin define list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/export-name-to-file-name.scm")))
    (else (include "export-name-to-file-name.scm"))))
