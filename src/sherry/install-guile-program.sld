
(define-library
  (sherry install-guile-program)
  (export install-guile-program)
  (import
    (only (euphrates append-posix-path)
          append-posix-path))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?))
  (import
    (only (euphrates get-current-directory)
          get-current-directory))
  (import
    (only (euphrates make-directories)
          make-directories))
  (import
    (only (euphrates path-get-basename)
          path-get-basename))
  (import
    (only (euphrates path-normalize) path-normalize))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates remove-common-prefix)
          remove-common-prefix))
  (import
    (only (euphrates run-syncproc) run-syncproc))
  (import
    (only (euphrates system-environment)
          system-environment-get))
  (import
    (only (scheme base)
          =
          and
          begin
          cond
          cons
          define
          else
          for-each
          if
          lambda
          let
          list
          newline
          null?
          or
          quote
          string-append
          unless))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/install-guile-program.scm")))
    (else (include "install-guile-program.scm"))))
