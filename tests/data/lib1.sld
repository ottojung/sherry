(define-library (tests data lib1)
  (export nothing)
  (import (scheme write))
  (import (scheme base))
  (cond-expand
   (guile
    ;; Should actually work but it does not matter for the test.
    (include-from-path "../tests/data/lib1.scm"))
   ((not whatever)
    (include "lib1.scm"))))
