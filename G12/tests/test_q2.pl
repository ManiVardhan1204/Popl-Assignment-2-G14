% Tests for P2. Run from the repo folder with:
%   swipl -q -f G12/tests/test_q2.pl -g run_tests -t halt
:- consult('../code/G12_q2.pl').

% check(+Name, +Goal)
% Prints PASS if Goal succeeds, FAIL if it fails or raises an error.
check(Name, Goal) :-
    (   catch(Goal, E, (print_message(error, E), fail))
    ->  format("PASS  ~w~n", [Name])
    ;   format("FAIL  ~w~n", [Name])
    ).

% seven(-Es): the 7 equations for [4,2,5,3] given in the assignment.
seven(["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
       "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"]).

% bracket_examples(-Pairs): the 8 bracket examples from the assignment.
bracket_examples([ times(plus(4,2),3)    - "(4+2)*3",
                   plus(4,times(2,3))    - "4+2*3",
                   times(divide(8,4),2)  - "8/4*2",
                   divide(8,times(4,2))  - "8/(4*2)",
                   minus(minus(1,2),3)   - "1-2-3",
                   minus(1,minus(2,3))   - "1-(2-3)",
                   plus(1,plus(2,3))     - "1+(2+3)",
                   plus(plus(1,2),3)     - "1+2+3" ]).

run_tests :-
    % examples from the assignment
    check(all_equations_4253,     (seven(S), all_equations([4,2,5,3], S))),
    check(all_equations_248,      all_equations([2,4,8], ["2*4=8"])),
    check(all_equations_234_empty, all_equations([2,3,4], [])),
    check(count_equations_4253_is_7, count_equations([4,2,5,3], 7)),
    check(generate_gives_one_of_7,
          (seven(S7), once(generate_equation([4,2,5,3], E)), memberchk(E, S7))),
    % failing cases
    check(generate_fails_234,     \+ generate_equation([2,3,4], _)),
    check(generate_fails_empty,   \+ generate_equation([], _)),
    check(generate_fails_single,  \+ generate_equation([5], _)),
    check(all_equations_empty_list, all_equations([], [])),
    check(count_single_is_0,      count_equations([5], 0)),
    % brackets
    check(eight_bracket_examples,
          (bracket_examples(Ps),
           forall(member(T-Want, Ps), (tree_string(T, Got), Got == Want)))),
    % division rules
    check(no_division_by_zero,    \+ expr([5,0], divide(_,_), _)),
    check(no_inexact_division,    \+ expr([2,3], divide(_,_), _)),
    check(exact_division_allowed, expr([6,3], divide(6,3), 2)),
    check(zeros_equation,         all_equations([0,0], ["0=0"])),
    % output type
    check(equation_is_string,     (generate_equation([2,4,8], E2), string(E2))).