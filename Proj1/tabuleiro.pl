initialBoard([
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty]
    ]).

midBoard([
    [empty,empty,plyr1,empty,plyr1,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [plyr2,empty,empty,plyr1,empty,empty],  
    [empty,empty,empty,empty,plyr2,plyr1],  
    [empty,plyr2,empty,empty,empty,empty],  
    [empty,empty,empty,empty,plyr2,empty]
    ]).

finalBoard([
    [plyr1,empty,empty,plyr1,empty,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [empty,plyr2,plyr2,plyr2,plyr1,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [plyr2,empty,plyr1,plyr1,empty,empty],  
    [empty,empty,empty,empty,empty,plyr2]  
    ]).
 
symbol(empty,S) :- S=' '.
symbol(plyr1,S) :- S='X'.
symbol(plyr2,S) :- S='O'.
symbol(_S,S) :- S='S'.

display_game(X):-
    nl,
    write('   | A | B | C | D | E | F |\n'),
    write('---|---|---|---|---|---|---|\n'),
    printMatrix(X,0).
    /*write('Player '), write(Player), write(' move:\n').*/

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
