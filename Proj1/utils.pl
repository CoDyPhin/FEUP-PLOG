flatten([], []) :- !.
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten(L, [L]).

getValueFromMatrix(Board, Row, Col, Value) :-
    Row > 0,
    Col > 0,
    nth1(Row, Board, NewRow),
    nth1(Col, NewRow, Value).


checkUpLeftPiece(Board,NewBoard,1,_):-
	NewBoard = Board.


checkUpLeftPiece(Board,NewBoard,_,1):-
	NewBoard = Board.


checkUpLeftPiece(Board, NewBoard, Row, Column):-
	Column > 2,
	Row > 2,
	AuxCol is Column-1,
	AuxRow is Row-1,
	NextAuxRow is Row-2,
	NextAuxCol is Column-2,
	getValueFromMatrix(Board, AuxRow, AuxCol, Piece),
	getValueFromMatrix(Board, NextAuxRow, NextAuxCol, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, NextAuxRow, NextAuxCol, Piece, TempBoard), replaceInMatrix(TempBoard, AuxRow, AuxCol, empty, NewBoard))) ; NewBoard = Board
	).
	
checkUpLeftPiece(Board, NewBoard, Row, Column):-
	Column > 1,
	Row > 1,
	AuxCol is Column-1,
	AuxRow is Row-1,
	replaceInMatrix(Board, AuxRow, AuxCol, empty, NewBoard).


checkUpPiece(Board, NewBoard, 1, _):-
	NewBoard = Board.

checkUpPiece(Board, NewBoard, Row, Column):-
	Row > 2,
	AuxRow is Row - 1,
	getValueFromMatrix(Board, AuxRow, Column, Piece),
	NextAuxRow is Row - 2,
	getValueFromMatrix(Board, NextAuxRow, Column, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, NextAuxRow, Column, Piece, TempBoard), replaceInMatrix(TempBoard, AuxRow, Column, empty, NewBoard))) ; NewBoard = Board
	).

checkUpPiece(Board, NewBoard, Row, Column):-
	Row > 1,
	AuxRow is Row-1,
	replaceInMatrix(Board, AuxRow, Column, empty, NewBoard).


checkUpRightPiece(Board, NewBoard, 1, _):-
	NewBoard = Board.


checkUpRightPiece(Board, NewBoard, _, 6):-
	NewBoard = Board.

checkUpRightPiece(Board, NewBoard, Row, Column):-
	Column < 5,
	Row > 2,
	AuxCol is Column+1,
	AuxRow is Row-1,
	NextAuxRow is Row-2,
	NextAuxCol is Column+2,
	getValueFromMatrix(Board, AuxRow, AuxCol, Piece),
	getValueFromMatrix(Board, NextAuxRow, NextAuxCol, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, NextAuxRow, NextAuxCol, Piece, TempBoard), replaceInMatrix(TempBoard, AuxRow, AuxCol, empty, NewBoard))) ; NewBoard = Board
	).

checkUpRightPiece(Board, NewBoard, Row, Column):-
	Column < 6,
	Row > 1,
	AuxCol is Column + 1,
	AuxRow is Row - 1,
	replaceInMatrix(Board, AuxRow, AuxCol, empty, NewBoard).

checkRightPiece(Board, NewBoard, _, 6):-
	NewBoard = Board.

checkRightPiece(Board, NewBoard, Row, Column):-
	Column < 5,
	AuxCol is Column + 1,
	getValueFromMatrix(Board, Row, AuxCol, Piece),
	NextAuxCol is Column + 2,
	getValueFromMatrix(Board, Row, NextAuxCol, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, Row, NextAuxCol, Piece, TempBoard), replaceInMatrix(TempBoard, Row, AuxCol, empty, NewBoard))) ; NewBoard = Board
	).

checkRightPiece(Board, NewBoard, Row, Column):-
	Column < 6,
	AuxCol is Column + 1,
	replaceInMatrix(Board, Row, AuxCol, empty, NewBoard).
    

checkDownRightPiece(Board, NewBoard, 6, _):-
	NewBoard = Board.

checkDownRightPiece(Board, NewBoard, _, 6):-
	NewBoard = Board.

checkDownRightPiece(Board, NewBoard, Row, Column):-
	Column < 5,
	Row < 5,
	AuxCol is Column+1,
	AuxRow is Row+1,
	NextAuxRow is Row+2,
	NextAuxCol is Column+2,
	getValueFromMatrix(Board, AuxRow, AuxCol, Piece),
	getValueFromMatrix(Board, NextAuxRow, NextAuxCol, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, NextAuxRow, NextAuxCol, Piece, TempBoard), replaceInMatrix(TempBoard, AuxRow, AuxCol, empty, NewBoard))) ; NewBoard = Board
	).

checkDownRightPiece(Board, NewBoard, Row, Column):-
	Column < 6,
	Row < 6,
	AuxCol is Column + 1,
	AuxRow is Row + 1,
	replaceInMatrix(Board, AuxRow, AuxCol, empty, NewBoard).

checkDownPiece(Board, NewBoard, 6, _):-
	NewBoard = Board.

checkDownPiece(Board, NewBoard, Row, Column):-
	Row < 5,
	AuxRow is Row + 1,
	getValueFromMatrix(Board, AuxRow, Column, Piece),
	NextAuxRow is Row + 2,
	getValueFromMatrix(Board, NextAuxRow, Column, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, NextAuxRow, Column, Piece, TempBoard), replaceInMatrix(TempBoard, AuxRow, Column, empty, NewBoard))) ; NewBoard = Board
	).

checkDownPiece(Board, NewBoard, Row, Column):-
	Row < 6,
	AuxRow is Row + 1,
	replaceInMatrix(Board, AuxRow, Column, empty, NewBoard).

checkDownLeftPiece(Board, NewBoard, 6, _):-
	NewBoard = Board.

checkDownLeftPiece(Board, NewBoard, _, 1):-
	NewBoard = Board.

checkDownLeftPiece(Board, NewBoard, Row, Column):-
	Column > 2,
	Row < 5,
	AuxCol is Column-1,
	AuxRow is Row+1,
	NextAuxRow is Row+2,
	NextAuxCol is Column-2,
	getValueFromMatrix(Board, AuxRow, AuxCol, Piece),
	getValueFromMatrix(Board, NextAuxRow, NextAuxCol, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, NextAuxRow, NextAuxCol, Piece, TempBoard), replaceInMatrix(TempBoard, AuxRow, AuxCol, empty, NewBoard))) ; NewBoard = Board
	).

checkDownLeftPiece(Board, NewBoard, Row, Column):-
	Column > 1,
	Row < 6,
	AuxCol is Column - 1,
	AuxRow is Row + 1,
	replaceInMatrix(Board, AuxRow, AuxCol, empty, NewBoard).

checkLeftPiece(Board, NewBoard, _, 1):-
	NewBoard = Board.

checkLeftPiece(Board, NewBoard, Row, Column):-
	Column > 2,
	AuxCol is Column - 1,
	getValueFromMatrix(Board, Row, AuxCol, Piece),
	NextAuxCol is Column - 2,
	getValueFromMatrix(Board, Row, NextAuxCol, NextPiece),
	(
		((Piece \= empty, NextPiece == empty) -> (replaceInMatrix(Board, Row, NextAuxCol, Piece, TempBoard), replaceInMatrix(TempBoard, Row, AuxCol, empty, NewBoard))) ; NewBoard = Board
	).

checkLeftPiece(Board, NewBoard, Row, Column):-
	Column > 1,
	AuxCol is Column - 1,
	replaceInMatrix(Board, Row, AuxCol, empty, NewBoard).
     