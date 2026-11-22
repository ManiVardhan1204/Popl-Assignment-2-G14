:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(aggregate)).

% split(+List, -Left, -Right)
% True when Left and Right are both non-empty and Left followed by Right is
% List. On backtracking it gives every such split, shortest Left first.
split(List, Left, Right) :-
    append(Left, Right, List),
    Left  \== [],
    Right \== [].