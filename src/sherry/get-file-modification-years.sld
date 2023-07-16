
(define-library
  (sherry get-file-modification-years)
  (export
    get-file-modification-years
    get-file-modification-years/print)
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate/reverse))
  (import
    (only (euphrates path-get-basename)
          path-get-basename))
  (import
    (only (euphrates path-get-dirname)
          path-get-dirname))
  (import
    (only (euphrates run-syncproc-re)
          run-syncproc/re))
  (import
    (only (euphrates string-to-lines) string->lines))
  (import
    (only (sherry get-current-year) get-current-year))
  (import
    (only (scheme base)
          _
          begin
          define
          for-each
          if
          lambda
          list
          map
          newline
          null?
          string->number))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/get-file-modification-years.scm")))
    (else (include "get-file-modification-years.scm"))))
