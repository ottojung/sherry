
(define-library
  (sherry update-file-license)
  (export
    update-file-license
    update-file-license/overwrite)
  (import
    (only (euphrates properties) set-property!))
  (import (only (euphrates raisu) raisu))
  (import
    (only (sherry file-license-exists-huh)
          file-license-exists?))
  (import
    (only (sherry file-modification-years)
          file-modification-years))
  (import
    (only (sherry infer-file-license)
          infer-file-license))
  (import
    (only (sherry license-up-to-date-huh)
          license-not-included-years/all-years
          license-not-included-years/current-year
          license-up-to-date?/all-years
          license-up-to-date?/current-year))
  (import
    (only (sherry license)
          license-author
          license-text
          license-years
          make-license))
  (import
    (only (sherry licensedfile)
          display-licensedfile
          file-license))
  (import (only (sherry log) log-info))
  (import
    (only (scheme base)
          and
          append
          begin
          cond
          define
          define-values
          else
          if
          lambda
          not
          or
          quote
          unless
          values
          when))
  (import
    (only (scheme file) call-with-output-file))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/update-file-license.scm")))
    (else (include "update-file-license.scm"))))
