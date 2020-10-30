initialBoard([
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty]
    ]).
 
symbol(empty,S) :- S=' '.
symbol(plyr1,S) :- S='X'.
symbol(plyr2,S) :- S='O'.
symbol(_S,S) :- S='S'.

printBoard(X):-
    nl,
    write('   | A | B | C | D | E | F |\n'),
    write('---|---|---|---|---|---|---|\n'),
    printMatrix(X,0).

printMatrix([],6).

printMatrix([H|T],X):-
    write(' '),
    X1 is X+1,
    write(X1),
    write(' | '),
    printLine(H),
    write('\n---|---|---|---|---|---|---|\n'),
    printMatrix(T, X1).

printLine([]).
printLine([H|T]):-
    symbol(H,S),
    write(S),
    write(' | '),
    printLine(T).
