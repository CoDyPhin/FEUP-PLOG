:-dynamic(state/2).

start :-
    initial(GameState),
    displayInitialBoard(GameState),
    gameLoop('Player1','Player2').

initial(GameState) :-
    initialBoard(GameState).

displayInitialBoard(GameState):-
    printBoard(GameState).

repeat.
repeat:-repeat.

gameLoop(Player1,Player2) :-
    initial(InitialBoard),
    assert(move(1,Player1)),
    assert(move(2,Player2)),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard)),
        assert(state(NextPlayer,UpdatedBoard)),
        fail.
    /*endGame.
    
endGame:-
    state(Player, Board),
    write('3 in a row!\n'),
    write('Player '),
    write(Player),
    write(' wins the game!').*/


playMove(Player, NextPlayer, Board, NewBoard):-
    write('Player '), write(Player), write(' move:\n'),
    readRow(R1, Row1),
    readColumn(C1, Col1),
    RowIndex is Row1 - 1,
    ColumnIndex is Col1 - 1,
    (   Player =:= 1 -> 
        replaceInMatrix(Board, RowIndex, ColumnIndex, plyr1, NewBoard)
    ;   Player =:= 2 ->
        replaceInMatrix(Board, RowIndex, ColumnIndex, plyr2, NewBoard)
    ),
    printBoard(NewBoard),
    (
		(Player =:= 1 ->
		    NextPlayer is 2
		);

		(Player =:= 2 ->
			NextPlayer is 1
		)
	),
    checkVictory(Player, NewBoard).

check3RowAux(MatValue, [], 7).
check3RowAux(MatValue, [Head|Tail], N):-
    N1 is N+1,
    check3Row(MatValue, Head, 0),
    check3RowAux(MatValue, Tail, N1).

check3Row(MatValue, [], Found).
check3Row(MatValue, [Head|Tail], Found):-
    (
        Found =:= 3 -> write('3 in a row found!\n')
        ;
        true
    ),
    symbol(MatValue, S1),
    symbol(Head, S2),
    (
        S1 = S2 ->
            check3Row(MatValue, Tail, Found+1)
        ;
            check3Row(MatValue, Tail, 0)
        
    ).

checkVictory(Player, Board):-
    (
        (Player =:= 1 ->
            check3RowAux(plyr1, Board, 1)
        );
        (Player =:= 2 ->
            check3RowAux(plyr2, Board, 1)
        )
    ).
