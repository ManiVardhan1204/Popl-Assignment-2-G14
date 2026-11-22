; Tests for S2. Run from the repo folder:
;   racket
;   (enter! "G12/code/G12_q4.rkt")
;   (load "G12/tests/test_q4.rktl")

; (check name actual expected): prints PASS if actual equals expected, else FAIL.
(define (check name actual expected)
  (if (equal? actual expected)
      (printf "PASS  ~a\n" name)
      (printf "FAIL  ~a\n   got:      ~s\n   expected: ~s\n" name actual expected)))

; (run-printer input): runs print-insert-result with input as standard input
; and returns what it printed, as a string.
(define (run-printer input)
  (let ((out (open-output-string)))
    (parameterize ((current-input-port (open-input-string input))
                   (current-output-port out))
      (print-insert-result))
    (get-output-string out)))

; (nest k): '() wrapped in k lists, e.g. (nest 2) = ((())).
(define (nest k)
  (if (= k 0) '() (list (nest (- k 1)))))

; (nest-expected k): what (insert-if-short 0 (nest k) 2) should give:
; every list there has length 0 or 1, so each one gets a 0 in front.
(define (nest-expected k)
  (if (= k 0) '(0) (list 0 (nest-expected (- k 1)))))

(define big (build-list 10000 (lambda (i) i)))

;; The 4 examples from the assignment
(check "example 1"
       (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)
       '((42 1 2) (3 4 5) (42 6) (42)))
(check "example 2"
       (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)
       '((0 (0 1) 2) (0 3) (0 (4 5 6) (0))))
(check "example 3: empty list, n = 3"
       (insert-if-short 7 '() 3)
       '(7))
(check "example 4: empty list, n = 0"
       (insert-if-short 7 '() 0)
       '())

;; Edge cases
(check "n = 0 changes nothing"
       (insert-if-short 'x '((1) (2 3) ()) 0)
       '((1) (2 3) ()))
(check "symbols as atoms"
       (insert-if-short 'z '(a (b c)) 3)
       '(z a (z b c)))
(check "nesting depth 100"
       (insert-if-short 0 (nest 100) 2)
       (nest-expected 100))
(check "10000 elements, too long for x"
       (insert-if-short 'x big 5)
       big)
(check "10000 elements, short enough for x"
       (insert-if-short 'x big 20000)
       (cons 'x big))

;; make-inserter directly
(check "make-inserter with = 2"
       ((make-inserter 'z (lambda (len) (= len 2))) '((a b) (c) (d e)))
       '((z a b) (c) (z d e)))

;; print-insert-result reading from standard input
(check "print-insert-result example 1"
       (run-printer "42 ((1 2) (3 4 5) (6) ()) 3")
       "((42 1 2) (3 4 5) (42 6) (42))\n")
(check "print-insert-result example 4"
       (run-printer "7 () 0")
       "()\n")