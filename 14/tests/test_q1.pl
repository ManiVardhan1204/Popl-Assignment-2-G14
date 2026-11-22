% Tests for P1. Run from the repo folder with:
%   swipl -q -f 14/tests/test_q1.pl -g run_tests -t halt
:- consult('../code/14_q1.pl').

% check(+Name, +Goal)
% Prints PASS if Goal succeeds, FAIL if it fails or raises an error.
check(Name, Goal) :-
    (   catch(Goal, E, (print_message(error, E), fail))
    ->  format("PASS  ~w~n", [Name])
    ;   format("FAIL  ~w~n", [Name])
    ).

% run_tests
% Runs every P1 check and prints one PASS/FAIL line per check.
run_tests :-
    check(no_clues_gives_13824,       count_solutions([], 13824)),
    check(clues_1_to_8_gives_3,       count_solutions([1,2,3,4,5,6,7,8], 3)),
    check(clues_1_to_9_gives_1,       count_solutions([1,2,3,4,5,6,7,8,9], 1)),
    check(clue_4_alone_gives_2592,    count_solutions([4], 2592)),
    check(clue_9_alone_gives_3456,    count_solutions([9], 3456)),
    check(clue_order_does_not_matter, count_solutions([8,7,6,5,4,3,2,1], 3)),
    check(main_prints_exact_output,
          ( with_output_to(string(Out), main),
            Out == "Alex = [design, java, AI]\nBen = [development, javascript, web]\nCarla = [research, c++, data]\nDana = [testing, python, embedded]\n" )).
