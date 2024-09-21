
(define-library
  (sherry my-fix-imports)
  (export my-fix-imports:main)
  (import
    (only (euphrates current-program-path-p)
          current-program-path/p))
  (import
    (only (euphrates define-cli)
          define-cli:show-help
          with-cli))
  (import
    (only (sherry fix-imports-generic)
          fix-imports/generic))
  (import
    (only (sherry scheme-imports)
          do-initialize-stdlib-exports))
  (import
    (only (scheme base)
          /
          begin
          define
          or
          parameterize
          quote
          when))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/my-fix-imports.scm")))
    (else (include "my-fix-imports.scm"))))
