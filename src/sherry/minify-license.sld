
(define-library
  (sherry minify-license)
  (export minify-license! minify-license/overwrite)
  (import
    (only (euphrates properties) set-property!))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates string-strip) string-strip))
  (import
    (only (euphrates string-to-lines) string->lines))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (sherry file-license-exists-huh)
          file-license-exists?))
  (import
    (only (sherry infer-file-license)
          infer-file-license))
  (import
    (only (sherry license)
          display-license
          license-prefix
          license-text))
  (import
    (only (sherry licensedfile)
          display-licensedfile
          file-license))
  (import (only (sherry log) log-info))
  (import
    (only (scheme base)
          begin
          define
          equal?
          if
          lambda
          map
          quote
          string-append
          unless))
  (import
    (only (scheme file) call-with-output-file))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/minify-license.scm")))
    (else (include "minify-license.scm"))))
