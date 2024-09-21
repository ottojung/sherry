
(define-library
  (sherry main)
  (import
    (only (euphrates current-program-path-p)
          current-program-path/p))
  (import
    (only (euphrates define-cli)
          define-cli:show-help
          with-cli))
  (import
    (only (euphrates file-or-directory-exists-q)
          file-or-directory-exists?))
  (import
    (only (euphrates properties) with-properties))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (sherry create-file)
          create-file-by-name/print))
  (import
    (only (sherry get-file-dependencies)
          get-file-dependencies/print))
  (import
    (only (sherry get-file-effective-module-declaration)
          get-file-effective-module-declaration))
  (import
    (only (sherry get-file-exports)
          get-file-exports/print))
  (import
    (only (sherry get-file-modification-years)
          get-file-modification-years/print))
  (import
    (only (sherry get-file-source-type)
          get-file-source-type/print))
  (import
    (only (sherry infer-file-license)
          infer-file-license/print))
  (import
    (only (sherry install-guile-program)
          install-guile-program))
  (import (only (sherry log-level-p) log-level/p))
  (import
    (only (sherry minify-license)
          minify-license/overwrite))
  (import
    (only (sherry r7rslibrary-to-r7rsprogram)
          r7rslibrary->r7rsprogram))
  (import
    (only (sherry update-file-license)
          update-file-license/overwrite))
  (import (only (sherry watch-file) watch-file))
  (import
    (only (scheme base)
          /
          and
          begin
          cond
          cons
          else
          if
          map
          newline
          or
          quote
          unless
          when))
  (import (only (scheme process-context) exit))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "sherry/main.scm")))
    (else (include "main.scm"))))
