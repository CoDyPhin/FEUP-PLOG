% GameStates (Delivery 1)
% Initial State
initialBoard([
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty]
    ]).

% Random Mid State
midBoard([
    [empty,empty,plyr1,empty,plyr1,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [plyr2,empty,empty,plyr1,empty,empty],  
    [empty,empty,empty,empty,plyr2,plyr1],  
    [empty,plyr2,empty,empty,empty,empty],  
    [empty,empty,empty,empty,plyr2,empty]
    ]).

% Random Final State
finalBoard([
    [plyr1,empty,empty,plyr1,empty,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [empty,plyr2,plyr2,plyr2,plyr1,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [plyr2,empty,plyr1,plyr1,empty,empty],  
    [empty,empty,empty,empty,empty,plyr2]  
    ]).
 
% Printable symbols for each value of the matrix
symbol(empty,' ').
symbol(plyr1,'X').
symbol(plyr2,'O').
symbol(_S,'S').

% Board Display
display_game(X, 0):-
    nl,
    write('   | A | B | C | D | E | F |\n'),
    write('---|---|---|---|---|---|---|\n'),
    printMatrix(X,0).

display_game(X, Player):-
    nl,
    write('   | A | B | C | D | E | F |\n'),
    write('---|---|---|---|---|---|---|\n'),
    printMatrix(X,0),
    write('Player '), write(Player), write(' move:\n').

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
