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

% op_info(+Tree, -Symbol, -Prec, -Left, -Right)
% Tree is an operator node with symbol Symbol, precedence Prec and operands
% Left and Right. + and - have precedence 1, * and / have precedence 2.
op_info(plus(L, R),   '+', 1, L, R).
op_info(minus(L, R),  '-', 1, L, R).
op_info(times(L, R),  '*', 2, L, R).
op_info(divide(L, R), '/', 2, L, R).

% prec(+Tree, -Prec)
% Prec is the precedence of Tree's top operator. A plain number gets 3,
% higher than any operator, so it never needs brackets.
prec(N, 3) :- integer(N).
prec(T, P) :- op_info(T, _, P, _, _).

% needs_brackets(+Side, +ChildPrec, +ParentPrec)
% A left operand needs brackets when its precedence is lower than the
% parent's; a right operand when it is the same or lower.
needs_brackets(left,  ChildP, ParentP) :- ChildP <  ParentP.
needs_brackets(right, ChildP, ParentP) :- ChildP =< ParentP.

% tree_string(+Tree, -String)
% String is Tree written in canonical form: no spaces, and brackets only
% where the rules above require them.
tree_string(N, S) :-
    integer(N),
    number_string(N, S).
tree_string(T, S) :-
    op_info(T, Sym, P, L, R),
    operand_string(L, left,  P, LS),
    operand_string(R, right, P, RS),
    atomics_to_string([LS, Sym, RS], S).

% operand_string(+Tree, +Side, +ParentPrec, -String)
% String is Tree as an operand on Side of a parent with precedence
% ParentPrec, wrapped in brackets if needs_brackets/3 says so.
operand_string(T, Side, ParentP, S) :-
    tree_string(T, S0),
    prec(T, ChildP),
    (   needs_brackets(Side, ChildP, ParentP)
    ->  atomics_to_string(['(', S0, ')'], S)
    ;   S = S0
    ).