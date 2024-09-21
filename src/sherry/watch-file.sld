
(define-library
  (sherry watch-file)
  (export watch-file)
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates dprintln) dprintln))
  (import (only (euphrates file-mtime) file-mtime))
  (import
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates path-replace-extension)
          path-replace-extension))
  (import (only (euphrates sys-usleep) sys-usleep))
  (import
    (only (sherry fix-imports-generic)
          fix-imports/generic))
  (import (only (sherry log) log-error))
  (import
    (only (scheme base)
          begin
          cond-expand
          current-error-port
          define
          define-values
          equal?
          for-each
          if
          lambda
          let
          list
          newline
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
             (only (system base compile) compile-file))
           (begin
             (include-from-path "sherry/watch-file.scm")))
    (else (include "watch-file.scm"))))
