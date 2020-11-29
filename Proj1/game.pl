:-dynamic(state/2).

initial(GameState) :-
    initialBoard(GameState).

repeat.
repeat:-repeat.

playGame('P1','P2'):-
    initial(InitialBoard),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard,0, Flag)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard,Winner, Flag),
    endGame(Winner, UpdatedBoard).
    
playGame('B1', 'B1'):-
    initial(InitialBoard),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard,1,Flag)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard,Winner,Flag),
    endGame(Winner, UpdatedBoard).

playGame('B1', 'B2'):-
    initial(InitialBoard),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        (
            Player =:= 2 -> PCFlag is 2; PCFlag is 1
        ),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard,PCFlag, Flag)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard,Winner,Flag),
    endGame(Winner, UpdatedBoard).

playGame('B2', 'B1'):-
    initial(InitialBoard),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        (
            Player =:= 2 -> PCFlag is 1; PCFlag is 2
        ),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard,PCFlag, Flag)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard,Winner,Flag),
    endGame(Winner).

playGame('B2', 'B2'):-
    initial(InitialBoard),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard,2, Flag)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard,Winner,Flag),
    endGame(Winner, UpdatedBoard).

playGame('P1', 'B2'):-
    initial(InitialBoard),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        (
            Player =:= 2 -> PCFlag is 2; PCFlag is 0
        ),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard,PCFlag, Flag)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard,Winner,Flag),
    endGame(Winner, UpdatedBoard).

playGame('P1', 'B1'):-
    initial(InitialBoard),
    assert(state(1,InitialBoard)),
    repeat,
        retract(state(Player,Board)),
        once(display_game(Board, Player)),
        (
            Player =:= 2 -> PCFlag is 1; PCFlag is 0
        ),
        once(playMove(Player,NextPlayer,Board,UpdatedBoard,PCFlag, Flag)),
        assert(state(NextPlayer,UpdatedBoard)),
        checkVictory(UpdatedBoard, Winner,Flag),
    endGame(Winner, UpdatedBoard).

endGame(Winner, FinalBoard):-
    retract(state(_,_)),
    (
        Winner =:= 0 -> mainMenu; (display_game(FinalBoard, 0), write('Player '), write(Winner), write(' wins the game!\n'), checkMMenuInput)
    ).

checkMMenuInput:-
    write('Return to main menu? [0] No    [1] Yes\n'),
    read(Input),
    manageInput(Input).

manageInput(0):- write('Exiting...\n').

manageInput(1):- mainMenu.

manageInput(_):- 
    write('Wrong option!\n Return to main menu? [0] No    [1] Yes\n'), 
    read(NewInput), 
    manageInput(NewInput).

move(GameState, Move, NewGameState):-
    nth1(1, Move, Row),
    nth1(2, Move, Col),
    nth1(3, Move, Player),
    (Player =:= 1 -> PValue = plyr1; (Player =:= 2 -> PValue = plyr2; fail)),
    replaceInMatrix(GameState, Row, Col, PValue, TempState),
    once(repulsions(TempState, NewGameState, Row, Col)).

playMove(2, 1, Board, NewBoard, 1, Flag):-
    choose_move(Board, 2, 1, Move),
    move(Board, Move, NewBoard),
    Flag is 0.

playMove(1, 2, Board, NewBoard, 1, Flag):-
    choose_move(Board, 1, 1, Move),
    move(Board, Move, NewBoard),
    Flag is 0.

playMove(1, 2, Board, NewBoard, 2, Flag):-
    choose_move(Board, 1, 2, Move),
    move(Board, Move, NewBoard),
    Flag is 0.

playMove(2, 1, Board, NewBoard, 2, Flag):-
    choose_move(Board, 2, 2, Move),
    move(Board, Move, NewBoard),
    Flag is 0.

playMove(1, 2, Board, NewBoard, 0, Flag):-
    (
        readInput(_, _, CRow, CCol, Board) ->
        (move(Board, [CRow, CCol, 1], NewBoard),
        Flag is 0);
        (Flag is 1, NewBoard = Board)
    ).

playMove(2, 1, Board, NewBoard, 0, Flag):-
    (
        readInput(_, _, CRow, CCol, Board) ->
        (move(Board, [CRow, CCol, 2], NewBoard),
        Flag is 0);
        (Flag is 1, NewBoard = Board)
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

game_over(GameState, Winner):-
    ( 
        checkAll(GameState,plyr1) -> Winner is 1; fail
    );
    (
        checkAll(GameState,plyr2) -> Winner is 2; fail
    ).

checkVictory(Board, Winner, Flag):-
    (
        Flag =:= 1 -> Winner is 0; fail
    );
    game_over(Board, Winner).
