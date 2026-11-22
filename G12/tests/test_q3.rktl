; Tests for S1. Run from the repo folder:
;   racket
;   (enter! "G12/code/G12_q3.rkt")
;   (load "G12/tests/test_q3.rktl")

; (output-of thunk): runs thunk and returns everything it printed, as a string.
(define (output-of thunk)
  (let ((out (open-output-string)))
    (parameterize ((current-output-port out))
      (thunk))
    (get-output-string out)))

; (check name actual expected): PASS if the strings are equal, else FAIL.
(define (check name actual expected)
  (if (equal? actual expected)
      (printf "PASS  ~a\n" name)
      (printf "FAIL  ~a\n   got:      ~s\n   expected: ~s\n" name actual expected)))

(define t1 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))
(define t4 '(m (k (j () ()) ()) (z () ())))   ; extra symbol tree
(define t5 '(5 () ()))                        ; single node

;; t1
(check "t1 print-inorder"
       (output-of (lambda () (print-inorder t1)))
       "(1 2 3 4 5 6 7)\n")
(check "t1 print-all-traversals"
       (output-of (lambda () (print-all-traversals t1)))
       "(1 2 3 4 5 6 7)\n(4 2 1 3 6 5 7)\n(1 3 2 5 7 6 4)\n")
(check "t1 print-height-and-leaves"
       (output-of (lambda () (print-height-and-leaves t1)))
       "(3 4)\n")

;; t2
(check "t2 print-all-traversals"
       (output-of (lambda () (print-all-traversals t2)))
       "(1 2 3)\n(1 2 3)\n(3 2 1)\n")
(check "t2 print-height-and-leaves"
       (output-of (lambda () (print-height-and-leaves t2)))
       "(3 1)\n")

;; t3
(check "t3 print-all-traversals"
       (output-of (lambda () (print-all-traversals t3)))
       "(b a c)\n(a b c)\n(b c a)\n")
(check "t3 print-height-and-leaves"
       (output-of (lambda () (print-height-and-leaves t3)))
       "(2 2)\n")

;; empty tree
(check "empty print-inorder"
       (output-of (lambda () (print-inorder '())))
       "()\n")
(check "empty print-all-traversals"
       (output-of (lambda () (print-all-traversals '())))
       "()\n()\n()\n")
(check "empty print-height-and-leaves"
       (output-of (lambda () (print-height-and-leaves '())))
       "(0 0)\n")

;; extra symbol tree
(check "t4 print-all-traversals"
       (output-of (lambda () (print-all-traversals t4)))
       "(j k m z)\n(m k j z)\n(j k z m)\n")
(check "t4 print-height-and-leaves"
       (output-of (lambda () (print-height-and-leaves t4)))
       "(3 2)\n")

;; single node
(check "single node print-all-traversals"
       (output-of (lambda () (print-all-traversals t5)))
       "(5)\n(5)\n(5)\n")
(check "single node print-height-and-leaves"
       (output-of (lambda () (print-height-and-leaves t5)))
       "(1 1)\n")