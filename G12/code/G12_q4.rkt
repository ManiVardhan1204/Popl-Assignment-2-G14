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

; (insert-if-short x lst n): copy of lst where x is put at the front of every
; list (at every nesting level, including lst itself and empty lists) whose
; original length is less than n.
; Recursive reading: first process every element (sublists recursively, atoms
; unchanged), then cons x onto the result if lst itself was shorter than n.
; The length is taken from the original lst, before anything is inserted.
(define (insert-if-short x lst n)
  (let ((processed
         (my-map (lambda (e)
                   (if (or (null? e) (pair? e))
                       (insert-if-short x e n)
                       e))
                 lst)))
    (if (< (my-length lst) n)
        (cons x processed)
        processed)))