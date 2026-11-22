#lang racket/base

; (my-length lst): number of top-level elements in lst.
; Uses a named-let loop with an accumulator, so it is tail recursive.
; Base: lst empty -> acc. Recursive: drop the first element, add 1 to acc.
(define (my-length lst)
  (let loop ((rest lst) (acc 0))
    (if (null? rest)
        acc
        (loop (cdr rest) (+ acc 1)))))

; (my-map f lst): new list with f applied to every element of lst, same order.
; Base: lst empty -> '(). Recursive: cons (f first) onto my-map of the rest.
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst)) (my-map f (cdr lst)))))

; (make-inserter x len-ok?): returns a function of one list. That function
; puts x at the front of every list (at every nesting level, including the
; list it is given and empty lists) whose original length satisfies len-ok?.
; Recursive reading of the returned function `insert`: process every element
; (sublists recursively, atoms unchanged), then cons x onto the result if
; (len-ok? (my-length lst)) holds for the original lst.
(define (make-inserter x len-ok?)
  (letrec ((insert
            (lambda (lst)
              (let ((processed
                     (my-map (lambda (e)
                               (if (or (null? e) (pair? e))
                                   (insert e)
                                   e))
                             lst)))
                (if (len-ok? (my-length lst))
                    (cons x processed)
                    processed)))))
    insert))

; (insert-if-short x lst n): insert x at the front of every list, at every
; nesting level, whose original length is less than n.
; Defined with make-inserter, using the length test (< len n).
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

; (print-insert-result): reads x, lst and n (in that order) from standard
; input with read, then displays (insert-if-short x lst n) and a newline.
; let* makes sure the three reads happen in order.
(define (print-insert-result)
  (let* ((x   (read))
         (lst (read))
         (n   (read)))
    (display (insert-if-short x lst n))
    (newline)))