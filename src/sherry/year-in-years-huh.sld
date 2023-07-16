
(define-library
  (sherry year-in-years-huh)
  (export year-in-years?)
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (sherry yearsrange)
          yearsrange-end
          yearsrange-start
          yearsrange?))
  (import
    (only (scheme base)
          <=
          >=
          and
          begin
          define
          equal?
          or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "sherry/year-in-years-huh.scm")))
    (else (include "year-in-years-huh.scm"))))
