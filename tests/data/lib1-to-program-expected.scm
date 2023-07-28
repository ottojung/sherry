
(cond-expand
  (guile)
  (else (import (scheme write))
        (import (scheme base))))

(define (say-hello)
  (display "Foo")
  (newline))

(say-hello)
