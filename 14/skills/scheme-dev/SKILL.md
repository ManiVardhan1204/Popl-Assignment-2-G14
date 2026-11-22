\---

name: scheme-dev

description: Use when writing, testing or reviewing restricted Racket/Scheme code for the PPL assignment (S1 trees, S2 nested insert).

\---



\# Scheme development skill



\## Environment

\- Racket 8.x. Every file starts with `#lang racket/base`.

\- Run: `racket file.rkt` (the grader appends its own calls to the end of the file).



\## Allowed built-ins (ONLY these)

define, lambda, let, let\*, letrec, named let, if, cond (with else), and, or, not, begin,

quote ('), cons, car, cdr, list, car/cdr compositions up to 4 levels (cadr, cddr, caddr,

cdddr, cadddr, cddddr, ...), null?, pair?, eq?, assq, assoc,

\+ - \* < > <= >= =, max, display, newline.

`read` is allowed ONLY in S2 (id\_q4.rkt).



\## Forbidden

set! and relatives, vectors, hash tables, strings, loops (do, for, for/list),

length, append, reverse, map, filter, member, memq, list-ref, list-tail,

when, unless, let-values, apply, foldl/foldr, and anything else not listed above.

If needed, write a helper: my-length, my-append, my-reverse, my-map.



\## File rules

\- Only definitions. Never call a function or print anything at the top level.

\- Pass all state through function arguments.



\## Conventions

\- kebab-case names; helpers prefixed `my-` when they replace a built-in.

\- Above every function, a comment with its recursive reading:

&#x20; ; (my-length lst acc): length of lst plus acc.

&#x20; ; Base: lst empty -> acc. Recursive: (my-length (cdr lst) (+ acc 1)).

\- Prefer tail recursion with an accumulator where natural.

\- Must work on lists of 10,000 elements and nesting depth 100.



\## Testing

\- Keep tests in a separate file in tests/ that loads the solution and calls the functions.

\- Test the spec examples plus edge cases: empty list/tree, single element, deep nesting, large lists.



\## Checklist before answering

1\. Every identifier used is on the allowed list, or is defined in this file.

2\. No top-level calls, no output when the file loads.

3\. Base cases handled ('() checked first).

4\. Output format exactly as specified, ending with a newline where required.

5\. Recursion terminates; large inputs won't blow up (accumulators where natural).

6\. Recursive-reading comment above each function.



\## Common AI mistakes with restricted Scheme

\- Quietly using length, append, reverse, map, list-ref or apply.

\- Using when/unless, for loops, or string functions to build output.

\- Leaving test calls like (print-inorder t1) at the top level.

\- Using else outside cond, or putting cond clauses in the wrong order.

\- Measuring a list's length after inserting into it instead of before.

\- Off-by-one base cases (height of the empty tree, leaves of the empty tree).

