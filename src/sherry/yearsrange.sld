
(define-library
  (sherry yearsrange)
  (export
    make-yearsrange
    yearsrange?
    yearsrange-start
    yearsrange-end)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "sherry/yearsrange.scm")))
    (else (include "yearsrange.scm"))))
