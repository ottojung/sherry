
(define-library
  (sherry r7rslibrary-to-r7rsprogram)
  (export r7rslibrary->r7rsprogram)
  (import
    (only (euphrates file-delete) file-delete))
  (import
    (only (euphrates path-replace-extension)
          path-replace-extension))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import
    (only (sherry file-module-declaration)
          file-module-declaration))
  (import
    (only (sherry pretty-print) pretty-print))
  (import
    (only (scheme base)
          and
          begin
          car
          define
          equal?
          for-each
          lambda
          newline
          null?
          or
          pair?
          quote
          unless))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/r7rslibrary-to-r7rsprogram.scm")))
    (else (include "r7rslibrary-to-r7rsprogram.scm"))))
