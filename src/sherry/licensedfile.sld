
(define-library
  (sherry licensedfile)
  (export
    parse-licensedfile
    file-prelicense-content
    file-license
    file-postlicense-content
    display-licensedfile)
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates irregex)
          irregex-match
          sre->irregex))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import
    (only (euphrates list-span-while)
          list-span-while))
  (import
    (only (euphrates properties)
          define-property
          define-provider))
  (import (only (euphrates range) range))
  (import
    (only (euphrates string-null-or-whitespace-p)
          string-null-or-whitespace?))
  (import (only (sherry file-lines) file-lines))
  (import
    (only (sherry license)
          display-license
          license-text
          parse-license-from-lines))
  (import
    (only (sherry shebang-line-huh) shebang-line?))
  (import
    (only (scheme base)
          *
          +
          and
          append
          begin
          car
          cdr
          cons
          current-output-port
          define
          define-values
          equal?
          for-each
          if
          lambda
          length
          let
          map
          newline
          null?
          parameterize
          quote
          values))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) any first)))
    (else (import (only (srfi 1) any first))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/licensedfile.scm")))
    (else (include "licensedfile.scm"))))
