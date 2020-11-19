:-dynamic(state/2).

play('P1', 'P2') :-
    initial(GameState),
    gameLoop('Player1','Player2').

initial(GameState) :-
    initialBoard(GameState).

repeat.
repeat:-repeat.

gameLoop(Player1,Player2) :-
    initial(InitialBoard),
    assert(move(1,Player1)),
    assert(move(2,Player2)),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard),
    display_game(UpdatedBoard, 0),
    endGame.
    
endGame:-
    winner(Player),
    write('Player '), write(Player), write(' wins the game!\n'),
    retract(winner(Player)),
    retract(move(_,_)),
    retract(state(_,_)),
    write('Return to main menu? [0] No    [1] Yes\n'),
    read(Input),
    manageInput(Input).

manageInput(0):- write('Exiting...\n').

manageInput(1):- mainMenu.

manageInput(_):- 
    write('Wrong option!\n Return to main menu? [0] No    [1] Yes\n'), 
    read(NewInput), 
    manageInput(NewInput).

playMove(Player, NextPlayer, Board, NewBoard):-
    readInput(Row1, Col1, CRow, CCol, Board),
    (   Player =:= 1 -> 
        replaceInMatrix(Board, CRow, CCol, plyr1, TempBoard)
    ;   Player =:= 2 ->
        replaceInMatrix(Board, CRow, CCol, plyr2, TempBoard)
    ),
    once(repulsions(TempBoard, NewBoard, CRow, CCol)),
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

repulsions(Board, NewBoard, Row, Column):-
	checkUpLeftPiece(Board, AuxBoard1, Row, Column),
	checkUpPiece(AuxBoard1, AuxBoard2, Row, Column),
	checkUpRightPiece(AuxBoard2, AuxBoard3, Row, Column),
	checkRightPiece(AuxBoard3, AuxBoard4, Row, Column),
	checkDownRightPiece(AuxBoard4, AuxBoard5, Row, Column),
	checkDownPiece(AuxBoard5, AuxBoard6, Row, Column),
	checkDownLeftPiece(AuxBoard6, AuxBoard7, Row, Column),
	checkLeftPiece(AuxBoard7, NewBoard, Row, Column),
	!.

checkVictory(Board):-
    ( 
        checkAll(Board,plyr1) -> assert(winner(1)); fail
    );
    (
        checkAll(Board,plyr2) -> assert(winner(2)); fail
    ).
