# \# CS F301 PPL – Assignment 2 (Group 14)

# 

# \*\*Members\*\*

# \- Mani Vardhan 2024A7PS0042H – P2, S1

# \- Sriyanth 2024A7PS0017H – P1, S2

# 

# \## Layout

# &#x20;   14/

# &#x20;     code/      14\_q1.pl 14\_q2.pl 14\_q3.rkt 14\_q4.rkt

# &#x20;     tests/     test\_q1.pl test\_q2.pl test\_q3.rktl test\_q4.rktl

# &#x20;     skills/    prolog-dev/SKILL.md scheme-dev/SKILL.md

# &#x20;     prompts/   P1.md P2.md S1.md S2.md (+ skills.md)

# &#x20;     P1\_REPORT.md

# 

# \## Running the tests (from the repo root)

# Prolog:

# 

# &#x20;   swipl -q -f 14/tests/test\_q1.pl -g run\_tests -t halt

# &#x20;   swipl -q -f 14/tests/test\_q2.pl -g run\_tests -t halt

# 

# Racket (the solution files define only the allowed built-ins and export nothing,

# so the tests are loaded inside each module):

# 

# &#x20;   racket

# &#x20;   > (enter! "14/code/14\_q3.rkt")

# &#x20;   > (load "14/tests/test\_q3.rktl")

# &#x20;   > (enter! "14/code/14\_q4.rkt")

# &#x20;   > (load "14/tests/test\_q4.rktl")

# 

# Environment used: SWI-Prolog 11.0.0, Racket 9.3.

