#lang racket/base

; Tree accessors. A tree is '() or (value left right).
(define (tree-value t) (car t))
(define (tree-left t)  (cadr t))
(define (tree-right t) (caddr t))

; (inorder-acc t acc): inorder values of t, followed by acc.
; Base: t empty -> acc.
; Recursive: left values, then the node value, then right values, then acc.
; Built from the right, so the result is in order with no append.
(define (inorder-acc t acc)
  (if (null? t)
      acc
      (inorder-acc (tree-left t)
                   (cons (tree-value t)
                         (inorder-acc (tree-right t) acc)))))

; (preorder-acc t acc): preorder values of t (node, left, right), then acc.
(define (preorder-acc t acc)
  (if (null? t)
      acc
      (cons (tree-value t)
            (preorder-acc (tree-left t)
                          (preorder-acc (tree-right t) acc)))))

; (postorder-acc t acc): postorder values of t (left, right, node), then acc.
(define (postorder-acc t acc)
  (if (null? t)
      acc
      (postorder-acc (tree-left t)
                     (postorder-acc (tree-right t)
                                    (cons (tree-value t) acc)))))

; Wrappers that start with an empty accumulator.
(define (inorder t)   (inorder-acc t '()))
(define (preorder t)  (preorder-acc t '()))
(define (postorder t) (postorder-acc t '()))

; (height t): height of tree t.
; Base: t empty -> 0.
; Recursive: 1 + the larger of the heights of the left and right subtrees.
(define (height t)
  (if (null? t)
      0
      (+ 1 (max (height (tree-left t))
                (height (tree-right t))))))

; (leaf-count t): number of leaves in t (nodes whose two subtrees are both empty).
; Base: t empty -> 0. A leaf -> 1.
; Recursive: leaves in the left subtree + leaves in the right subtree.
(define (leaf-count t)
  (cond ((null? t) 0)
        ((and (null? (tree-left t)) (null? (tree-right t))) 1)
        (else (+ (leaf-count (tree-left t))
                 (leaf-count (tree-right t))))))