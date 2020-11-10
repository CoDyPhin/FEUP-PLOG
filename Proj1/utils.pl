/*transposeMat([], []).
transposeMat([F|Fs], Ts) :-
    transposeMat(F, [F|Fs], Ts).

transposeMat([], _, []).
transposeMat([_|Rs], Ms, [Ts|Tss]) :-
        lists_firsts_rests(Ms, Ts, Ms1),
        transposeMat(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :-
        lists_firsts_rests(Rest, Fs, Oss).

getValueFromList([H|_T], 0, Value) :-
        Value = H.

getValueFromList([_H|T], Index, Value) :-
        Index > 0,
        Index1 is Index - 1,
        getValueFromList(T, Index1, Value).

getValueFromMatrix([H|_T], 0, Column, Value) :-
        getValueFromList(H, Column, Value).

getValueFromMatrix([_H|T], Row, Column, Value) :-
        Row > 0,
        Row1 is Row - 1,
        getValueFromMatrix(T, Row1, Column, Value).
*/

/*addPieceCounter:- bb_get(npieces, X), write('Counter: '), write(X), write('\t'), X2 is X+1, bb_put(npieces, X2).

checkCounter:- bb_get(npieces, X), X =:= 8.*/

flatten([], []) :- !.
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten(L, [L]).

getValueFromMatrix(Board, Row, Col, Value) :-
    nth1(Row, Board, NewRow),
    nth1(Col, NewRow, Value).
