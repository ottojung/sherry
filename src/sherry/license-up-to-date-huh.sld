
(define-library
  (sherry license-up-to-date-huh)
  (export
    license-up-to-date?/all-years
    license-not-included-years/all-years
    license-up-to-date?/current-year
    license-not-included-years/current-year)
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import
    (only (sherry file-license-exists-huh)
          file-license-exists?))
  (import
    (only (sherry file-modification-years)
          file-modification-years))
  (import
    (only (sherry get-current-year) get-current-year))
  (import
    (only (sherry license)
          license-filepath
          license-years))
  (import
    (only (sherry year-in-years-huh) year-in-years?))
  (import
    (only (scheme base)
          and
          begin
          define
          equal?
          if
          lambda
          not
          null?
          values))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/license-up-to-date-huh.scm")))
    (else (include "license-up-to-date-huh.scm"))))
