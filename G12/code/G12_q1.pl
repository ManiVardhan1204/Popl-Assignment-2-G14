:- use_module(library(lists)).

% solution(-S)
% S is a candidate solution: one p(Name, Dept, Lang, Project) term per friend,
% in the order Alex, Ben, Carla, Dana, where each attribute's four values are
% a permutation of the allowed values, so every value is used exactly once.
solution([p('Alex',  D1, L1, P1),
          p('Ben',   D2, L2, P2),
          p('Carla', D3, L3, P3),
          p('Dana',  D4, L4, P4)]) :-
    permutation([research, development, design, testing], [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript],        [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data],               [P1, P2, P3, P4]).


% clue(+N, +S)
% True when clue number N holds in the fully filled-in solution S.
% Each value of each attribute belongs to exactly one friend, so memberchk/2
% finds "the friend who has value X" deterministically.

% CLUE 1: The friend who prefers the AI project does not work in research and is not Dana.
clue(1, S) :-
    memberchk(p(Name, Dept, _, 'AI'), S),
    Dept \== research,
    Name \== 'Dana'.

% CLUE 2: Alex does not work in development and does not prefer C++.
clue(2, S) :-
    memberchk(p('Alex', Dept, Lang, _), S),
    Dept \== development,
    Lang \== 'c++'.

% CLUE 3: The friend working in the testing department likes Python.
clue(3, S) :-
    memberchk(p(_, testing, Lang, _), S),
    Lang == python.

% CLUE 4: Ben prefers web projects and does not work in testing.
clue(4, S) :-
    memberchk(p('Ben', Dept, _, Proj), S),
    Proj == web,
    Dept \== testing.

% CLUE 5: The friend whose favorite language is Java works in the design department.
clue(5, S) :-
    memberchk(p(_, Dept, java, _), S),
    Dept == design.

% CLUE 6: Carla's project preference is not embedded, and her department is not development.
clue(6, S) :-
    memberchk(p('Carla', Dept, _, Proj), S),
    Proj \== embedded,
    Dept \== development.

% CLUE 7: Dana's favorite language is not Java, and she works in research or testing.
clue(7, S) :-
    memberchk(p('Dana', Dept, Lang, _), S),
    Lang \== java,
    memberchk(Dept, [research, testing]).

% CLUE 8: The friend who prefers data projects works in research and does not use JavaScript.
clue(8, S) :-
    memberchk(p(_, Dept, Lang, data), S),
    Dept == research,
    Lang \== javascript.