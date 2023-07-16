
(define-library
  (sherry create-file)
  (export
    create-file-by-name
    create-file-by-name/print)
  (import (only (euphrates comp) appcomp))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import
    (only (euphrates write-string-file)
          write-string-file))
  (import
    (only (sherry export-name-to-file-name)
          export-name->file-name))
  (import
    (only (sherry file-module-declaration)
          file-module-declaration))
  (import
    (only (sherry file-neighbours) file-neighbours))
  (import
    (only (sherry file-source-type) file-source-type))
  (import
    (only (sherry module-declaration-replace-exports)
          module-declaration-replace-exports))
  (import
    (only (sherry module-declaration-replace-name)
          module-declaration-replace-name))
  (import
    (only (sherry update-file-license)
          update-file-license/overwrite))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          lambda
          let
          list
          newline
          or
          quasiquote
          quote
          string->symbol
          string-append
          unquote))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (ice-9 pretty-print) pretty-print))
           (begin
             (include-from-path "sherry/create-file.scm")))
    (else (include "create-file.scm"))))
