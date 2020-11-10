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
        checkVictory(UpdatedBoard),
    endGame.
    
endGame:-
    winner(Player),
    write('Player '), write(Player), write(' wins the game!\n').


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
	).

threeInLDiag(0,_,_,_,_).

threeInLDiag(Counter,Row,Col,Board,Value):-
    Row < 7,
    Col < 7,
    getValueFromMatrix(Board,Row,Col,Value),
    NewRow is Row-1,
    NewCol is Col-1,
    NewCounter is Counter-1,
    threeInLDiag(NewCounter,NewRow,NewCol,Board,Value),!.

threeInRDiag(0,_,_,_,_).

threeInRDiag(Counter,Row,Col,Board,Value):-
    Row < 7,
    Col < 7,
    getValueFromMatrix(Board,Row,Col,Value),
    NewRow is Row-1,
    NewCol is Col+1,
    NewCounter is Counter-1,
    threeInRDiag(NewCounter,NewRow,NewCol,Board,Value),!.

threeInCol(0,_,_,_,_).

threeInCol(Counter,Row,Col,Board,Value):-
    Row < 7,
    Col < 7,
    getValueFromMatrix(Board,Row,Col,Value),
    NewRow is Row-1,
    NewCounter is Counter-1,
    threeInCol(NewCounter,NewRow,Col,Board,Value),!.

eightOnBoard(_,_,_,0).
eightOnBoard(Board, Index, Value, Counter):-
    Index < 37,
    NewI is Index+1,
    (
        nth1(Index, Board, Value) -> NewC is Counter-1; NewC is Counter
    ),
    eightOnBoard(Board, NewI, Value, NewC),!.


threeInRow(0,_,_,_,_).

threeInRow(Counter,Row,Col,Board,Value):-
    Row < 7,
    Col < 7,
    getValueFromMatrix(Board,Row,Col,Value),
    NewCol is Col-1,
    NewCounter is Counter-1,
    threeInRow(NewCounter,Row,NewCol,Board,Value),!.

checkAllAux(Row,Col,Board,Value):-
    Row > 0,
    Col > 0,
    threeInRow(3,Row,Col,Board,Value);
    threeInCol(3,Row,Col,Board,Value);
    threeInRDiag(3,Row,Col,Board,Value);
    threeInLDiag(3,Row,Col,Board,Value).

checkAllAux(Row,Col,Board,Value):-
    Row > 0,
    Col > 0,
    NextRow is Row-1,
    checkAllAux(NextRow,Col,Board,Value).

checkAllAux(Row,Col,Board,Value):-
    Row > 0,
    Col > 0,
    NextCol is Col-1,
    checkAllAux(Row,NextCol,Board,Value).

checkAll(Board,Value):-
    flatten(Board, FlatBoard),
    eightOnBoard(FlatBoard, 1, Value, 8);
    checkAllAux(7,7,Board,Value).

checkVictory(Board):-
    retract(winner(Player)),
    assert(winner(1)),
    checkAll(Board,plyr1);
    assert(winner(2)),
    checkAll(Board,plyr2).
