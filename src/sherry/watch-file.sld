
(define-library
  (sherry watch-file)
  (export watch-file)
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates dprintln) dprintln))
  (import (only (euphrates file-mtime) file-mtime))
  (import (only (euphrates sys-usleep) sys-usleep))
  (import
    (only (sherry fix-imports-generic)
          fix-imports/generic))
  (import
    (only (scheme base)
          begin
          cond-expand
          current-error-port
          define
          equal?
          lambda
          let
          newline
          set!
          unless))
  (import (only (scheme load) load))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import
             (only (system base compile) compile-file))
           (begin
             (include-from-path "sherry/watch-file.scm")))
    (else (include "watch-file.scm"))))
