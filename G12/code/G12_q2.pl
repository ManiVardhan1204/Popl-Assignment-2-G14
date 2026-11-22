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

% expr(+Nums, -Tree, -Value)
% Tree is an expression over the numbers in Nums, used once each and in the
% given order, built from plus/2, minus/2, times/2, divide/2 and plain
% numbers. Value is its integer value. Every division in the tree has a
% non-zero divisor and divides exactly. Gives every such tree on backtracking.
expr([N], N, N) :-
    integer(N).
expr(Nums, Tree, Value) :-
    split(Nums, LeftNums, RightNums),
    expr(LeftNums,  LeftTree,  LeftVal),
    expr(RightNums, RightTree, RightVal),
    combine(LeftTree, LeftVal, RightTree, RightVal, Tree, Value).

% combine(+LT, +LV, +RT, +RV, -Tree, -Value)
% Tree joins LT and RT with one operator, and Value is its value, given
% that LT has value LV and RT has value RV. Division is only allowed when
% RV is not 0 and LV is an exact multiple of RV.
combine(L, LV, R, RV, plus(L, R),   V) :- V is LV + RV.
combine(L, LV, R, RV, minus(L, R),  V) :- V is LV - RV.
combine(L, LV, R, RV, times(L, R),  V) :- V is LV * RV.
combine(L, LV, R, RV, divide(L, R), V) :-
    RV =\= 0,
    LV mod RV =:= 0,
    V is LV // RV.