
(define-library
  (sherry infer-file-license)
  (export
    infer-file-license
    infer-file-license/print)
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-map-first) list-map-first))
  (import
    (only (euphrates string-null-or-whitespace-p)
          string-null-or-whitespace?))
  (import (only (sherry file-lines) file-lines))
  (import
    (only (sherry file-neighbours) file-neighbours))
  (import
    (only (sherry get-file-modification-years)
          get-file-modification-years))
  (import
    (only (sherry license)
          display-license
          license-author
          license-text
          make-license))
  (import
    (only (sherry licensedfile) file-license))
  (import (only (sherry log) log-error log-info))
  (import
    (only (scheme base) and begin define if let or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/infer-file-license.scm")))
    (else (include "infer-file-license.scm"))))
