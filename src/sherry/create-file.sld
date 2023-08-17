
(define-library
  (sherry create-file)
  (export
    create-file-by-name
    create-file-by-name/print)
  (import
    (only (euphrates catchu-case) catchu-case))
  (import (only (euphrates comp) appcomp))
  (import
    (only (euphrates list-maximal-element-or)
          list-maximal-element-or))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates random-variable-name)
          random-variable-name))
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
    (only (sherry file-effective-module-declaration)
          file-effective-module-declaration))
  (import
    (only (sherry file-license-exists-huh)
          file-license-exists?))
  (import
    (only (sherry file-neighbours) file-neighbours))
  (import
    (only (sherry file-source-type) file-source-type))
  (import (only (sherry log) log-info))
  (import
    (only (sherry module-declaration-replace-exports)
          module-declaration-replace-exports))
  (import
    (only (sherry module-declaration-replace-name)
          module-declaration-replace-name))
  (import
    (only (sherry pretty-print) pretty-print))
  (import
    (only (sherry update-file-license)
          update-file-license/overwrite))
  (import
    (only (scheme base)
          <
          >
          begin
          cond
          define
          else
          equal?
          if
          lambda
          length
          let
          list
          newline
          or
          quasiquote
          quote
          string->symbol
          string-append
          string<?
          unquote))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/create-file.scm")))
    (else (include "create-file.scm"))))
