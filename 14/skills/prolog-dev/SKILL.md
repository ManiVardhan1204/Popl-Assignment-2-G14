\---

name: prolog-dev

description: Use when writing, testing or reviewing SWI-Prolog 9 code for the PPL assignment (P1 puzzle, P2 equations).

\---



\# Prolog development skill



\## Environment

\- SWI-Prolog 9.x

\- Run main: `swipl -q -f file.pl -g main -t halt`

\- Run any goal: `swipl -q -f file.pl -g "goal" -t halt`



\## Hard rules

\- Allowed libraries ONLY: lists, apply, yall, aggregate. (No clpfd, no dcg/basics, no strings library extras.)

\- No assert, retract, b\_setval, nb\_setval or any global state.

\- No halt/0 and no `:- initialization` directive anywhere in the file.

\- File contains only definitions. Print nothing except what main/0 is specified to print.

\- Do not hard-code answers; derive them from the rules/clues.

\- Give one unit of work per answer (one predicate or one small group of clauses), not a whole problem.



\## Conventions

\- snake\_case predicate names, descriptive variable names.

\- Above every predicate, a comment with its mode and declarative reading:

