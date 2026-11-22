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