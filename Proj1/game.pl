:-dynamic(state/2).

play :-
    initial(GameState),
    displayInitialBoard(GameState, 1),
    gameLoop('Player1','Player2').

initial(GameState) :-
    initialBoard(GameState).

displayInitialBoard(GameState, Player):-
    display_game(GameState, Player).

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
        once(display_game(UpdatedBoard, NextPlayer)),
        fail.
    /*endGame.
    
endGame:-
    state(Player, Board),
    write('3 in a row!\n'),
    write('Player '),
    write(Player),
    write(' wins the game!').*/


playMove(Player, NextPlayer, Board, NewBoard):-
    readRow(R1, Row1),
    readColumn(C1, Col1),
    RowIndex is Row1 - 1,
    ColumnIndex is Col1 - 1,
    (   Player =:= 1 -> 
        replaceInMatrix(Board, RowIndex, ColumnIndex, plyr1, NewBoard)
    ;   Player =:= 2 ->
        replaceInMatrix(Board, RowIndex, ColumnIndex, plyr2, NewBoard)
    ),
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

check3DiagonalR(MatValue, Board, 4, 4, Found).

check3DiagonalR(MatValue, Board, NRow, NCol, Found):-
    (
        NCol > 4 ->
            Found is 0
        ;
            true
    ),
    (
        NCol > 4 ->
            NRow is NRow+1
        ;
            true
    ),
    (
        NCol > 4 ->
            NCol is 1
        ;
            true
    ),
    (
        Found =:= 3 -> write('3 in a diagonal found!\n')
        ;
        true
    ),
    getValueFromMatrix(Board, NRow, NCol, Value),
    symbol(Value, S1),
    symbol(MatValue, S2),
    (
        S1 = S2 -> 
            check3DiagonalR(MatValue, Board, NRow+1, NCol+1, Found+1)
        ;
            check3DiagonalR(MatValue, Board, NRow, NCol+1, 0)
    ).

checkVictory(Player, Board):-
    (
        (Player =:= 1 ->
            check3RowAux(plyr1, Board, 1)
        );
        (Player =:= 2 ->
            check3RowAux(plyr2, Board, 1)
        )
    ),
    transposeMat(Board, TBoard),
    (
        (Player =:= 1 ->
            check3RowAux(plyr1, TBoard, 1)
        );
        (Player =:= 2 ->
            check3RowAux(plyr2, TBoard, 1)
        )
    ).
    /*(
        (Player =:= 1 ->
            check3DiagonalR(plyr1, Board, 1, 1, 0)
        );
        (Player =:= 2 ->
            check3DiagonalR(plyr2, Board, 1, 1, 0)
        )
    ).*/
