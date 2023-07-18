
(cond-expand
  (guile)
  ((not guile)
   (import (scheme write))
   (import (scheme base))))

(define (say-hello)
  (display "Foo")
  (newline))

(say-hello)
