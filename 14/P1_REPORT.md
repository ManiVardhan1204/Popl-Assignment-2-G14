\# P1 Report



\## P1.b: number of solutions for clues 1 to 8



`count\_solutions(\[1,2,3,4,5,6,7,8], N)` gives \*\*N = 3\*\*.



Without any clues there are 4! x 4! x 4! = 13824 possible assignments.

Clues 1 to 8 cut this down to 3, so the puzzle as given is \*\*not uniquely solvable\*\*:

the clues are consistent (N > 0) but under-constrained (N > 1).



The three solutions:



| | Alex | Ben | Carla | Dana |

|---|---|---|---|---|

| 1 | design, java, AI | development, javascript, web | research, c++, data | testing, python, embedded |

| 2 | design, java, embedded | development, javascript, web | testing, python, AI | research, c++, data |

| 3 | testing, python, embedded | development, javascript, web | design, java, AI | research, c++, data |



Ben is fully determined (development, javascript, web) in every solution, and the

c++ user always works in research and prefers data projects. What is left open is

how the remaining pairs (design + java, testing + python) and the AI/embedded

projects are shared out among Alex, Carla and Dana.



\## P1.c: clue 9



\*\*Clue 9: The friend who likes Python prefers the AI project.\*\*



It is true only in solution 2 (Carla: testing, python, AI). In solutions 1 and 3

the Python user (Dana and Alex) prefers embedded, so they are ruled out.

With it, `count\_solutions(\[1,2,3,4,5,6,7,8,9], N)` gives N = 1.

