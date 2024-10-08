
(define-library
  (sherry watch-file)
  (export watch-file)
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates dprintln) dprintln))
  (import
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates path-replace-extension)
          path-replace-extension))
  (import (only (euphrates sys-usleep) sys-usleep))
  (import
    (only (euphrates with-run-time-estimate)
          with-run-time-estimate))
  (import
    (only (sherry file-externally-modified-huh)
          file:externally-modified?))
  (import
    (only (sherry file-modification-time-update-bang)
          file:modification-time:update!))
  (import (only (sherry log) log-error log-info))
  (import
    (only (scheme base)
          begin
          current-error-port
          define
          define-values
          for-each
          if
          lambda
          let
          list
          newline
          parameterize
          unless
          values
          when))
  (import (only (scheme load) load))
  (import (only (scheme process-context) exit))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-suffix?)))
    (else (import (only (srfi 13) string-suffix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (only (system base compile)
                   default-optimization-level
                   compile-file
                   compiled-file-name))
           (begin
             (include-from-path "sherry/watch-file.scm")))
    (else (include "watch-file.scm"))))
