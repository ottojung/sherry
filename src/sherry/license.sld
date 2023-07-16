
(define-library
  (sherry license)
  (export
    make-license
    license-author
    license-years
    license-text
    license-prefix
    license-filepath
    display-license
    parse-license-from-lines)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates irregex)
          irregex-match-substring
          irregex-replace
          irregex-search
          sre->irregex))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import
    (only (euphrates list-maximal-element-or-proj)
          list-maximal-element-or/proj))
  (import
    (only (euphrates properties)
          define-property
          define-provider
          set-property!))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates string-split-3) string-split-3))
  (import
    (only (euphrates string-strip) string-strip))
  (import
    (only (euphrates string-to-lines) string->lines))
  (import
    (only (euphrates string-to-words) string->words))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (sherry yearsrange)
          make-yearsrange
          yearsrange-end
          yearsrange-start
          yearsrange?))
  (import
    (only (scheme base)
          *
          +
          >
          and
          begin
          car
          cdr
          cond
          cons
          current-output-port
          define
          define-values
          else
          if
          lambda
          let
          list
          map
          newline
          null?
          or
          parameterize
          quote
          string->number
          string-append
          string-length
          values
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter first)))
    (else (import (only (srfi 1) filter first))))
  (cond-expand
    (guile (import
             (only (srfi srfi-13) string-join string-null?)))
    (else (import
            (only (srfi 13) string-join string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "sherry/license.scm")))
    (else (include "license.scm"))))
