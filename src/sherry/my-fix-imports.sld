
(define-library
  (sherry my-fix-imports)
  (import
    (only (euphrates current-program-path-p)
          current-program-path/p))
  (import
    (only (euphrates define-cli)
          define-cli:show-help
          with-cli))
  (import
    (only (sherry file-read-first-expression)
          file-read-first-expression))
  (import
    (only (sherry is-guile-decl-huh) is-guile-decl?))
  (import
    (only (sherry scheme-imports)
          czempak-main
          do-initialize-stdlib-exports
          guile-main
          r7rs-main))
  (import
    (only (scheme base)
          /
          begin
          cond
          else
          equal?
          let
          or
          parameterize
          quote
          when))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (srfi srfi-42) :)))
    (else (import (only (srfi 42) :))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/my-fix-imports.scm")))
    (else (include "my-fix-imports.scm"))))
