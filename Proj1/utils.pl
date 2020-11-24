indexToCol(ColNum, ColString):-
	nth1(ColNum, ['A','B','C','D','E','F'], ColString).

flatten([], []) :- !.
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten(L, [L]).

replaceInList([_H|T], 1, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
    Index > 1,
    Index1 is Index - 1,
    replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 1, Column,Value, [HNew|T]) :-
    replaceInList(H, Column, Value, HNew).

replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
    Row > 1,
    Row1 is Row - 1,
    replaceInMatrix(T, Row1, Column, Value, TNew).

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
     

piecesOnBoard(_,37,_,Counter,Points):- Points is Counter.

piecesOnBoard(Board, Index, Value, Counter, Points):-
    NewI is Index+1,
    (
        nth1(Index, Board, Value) -> NewC is Counter+1; NewC is Counter
    ),
    piecesOnBoard(Board, NewI, Value, NewC, Points),!.

twoInCol(_,0,0,_,_,CurrentPoints, FinalPoints):- FinalPoints = CurrentPoints.

twoInCol(Counter,0,Col,Board, Value, CurrentPoints, FinalPoints):- 
	NewCol is Col-1,
	twoInCol(0, 6, NewCol, Board, Value, CurrentPoints, FinalPoints).

twoInCol(Counter,Row,Col,Board,Value, CurrentP, Points):-
	(
		Counter =:= 2 -> (NewCounter is 0, NewCurrentP is CurrentP+1); 
		(NewCounter is Counter, NewCurrentP is CurrentP)
	),
    (
		getValueFromMatrix(Board,Row,Col,Value) -> NCounter is NewCounter+1; NCounter is 0
	),
	NewRow is Row-1,
	twoInCol(NCounter,NewRow,Col,Board,Value, NewCurrentP, Points).


/*twoInRDiag(_,_,_,1,1,_,_,CurrentPoints, FinalPoints):- FinalPoints = CurrentPoints.

twoInRDiag(Counter,0,_,RowCounter,1,Board, Value, CurrentPoints, FinalPoints):- 
	NewRCounter is RowCounter-1,
	NewRow is RowCounter,
	twoInRDiag(0, NewRow, 6,NewRCounter,1, Board, Value, CurrentPoints, FinalPoints).

twoInRDiag(Counter,_,_,6,1,Board, Value, CurrentPoints, FinalPoints):- 
	NewRCounter is RowCounter-1,
	NewRow is RowCounter,
	twoInRDiag(0, NewRow, 6,NewRCounter,1, Board, Value, CurrentPoints, FinalPoints).

twoInRDiag(Counter,_,0,6,ColCounter,Board, Value, CurrentPoints, FinalPoints):- 
	NewCCounter is ColCounter-1,
	NewCol is ColCounter,
	twoInRDiag(0, 6, NewCol,RowCounter,NewCCounter, Board, Value, CurrentPoints, FinalPoints).

twoInRDiag(Counter,Row,Col,RowCounter, ColCounter, Board,Value, CurrentP, Points):-
	(
		Counter =:= 2 -> (NewCounter is 0, NewCurrentP is CurrentP+1); 
		(NewCounter is Counter, NewCurrentP is CurrentP)
	),
    (
		getValueFromMatrix(Board,Row,Col,Value) -> NCounter is NewCounter+1; NCounter is 0
	),
	NewCol is Col-1,
	NewRow is Row-1,
	twoInRDiag(NCounter,NewRow,NewCol,RowCounter,ColCounter,Board,Value, NewCurrentP, Points).


twoInLDiag(_,_,_,1,6,_,_,CurrentPoints, FinalPoints):- FinalPoints = CurrentPoints.

twoInLDiag(Counter,0,_,RowCounter,6,Board, Value, CurrentPoints, FinalPoints):- 
	NewRCounter is RowCounter-1,
	NewRow is RowCounter,
	twoInLDiag(0, NewRow, 1,NewRCounter,6, Board, Value, CurrentPoints, FinalPoints).

twoInLDiag(Counter,_,_,6,6,Board, Value, CurrentPoints, FinalPoints):- 
	NewRCounter is RowCounter-1,
	NewRow is RowCounter,
	twoInLDiag(0, NewRow, 1,NewRCounter,6, Board, Value, CurrentPoints, FinalPoints).

twoInLDiag(Counter,_,7,6,ColCounter,Board, Value, CurrentPoints, FinalPoints):- 
	NewCCounter is ColCounter+1,
	NewCol is ColCounter,
	twoInLDiag(0, 6, NewCol,RowCounter,NewCCounter, Board, Value, CurrentPoints, FinalPoints).

twoInLDiag(Counter,Row,Col,RowCounter, ColCounter, Board,Value, CurrentP, Points):-
	(
		Counter =:= 2 -> (NewCounter is 0, NewCurrentP is CurrentP+1); 
		(NewCounter is Counter, NewCurrentP is CurrentP)
	),
    (
		getValueFromMatrix(Board,Row,Col,Value) -> NCounter is NewCounter+1; NCounter is 0
	),
	NewCol is Col+1,
	NewRow is Row-1,
	twoInLDiag(NCounter,NewRow,NewCol,RowCounter,ColCounter,Board,Value, NewCurrentP, Points).*/

twoInRDiag(5,6,_,_, Points, FinalPoints):-
	FinalPoints = Points.


twoInRDiag(Row, Col, Board, Value, Points, FinalPoints):-
	Row < 6,
	Col < 6,
	NewRow is Row + 1,
	NewCol is Col + 1,
	getValueFromMatrix(Board, Row, Col,V1),
	getValueFromMatrix(Board, NewRow, NewCol, V2),
	((V1 == Value, V2 == Value) -> (NewPoints is Points+1, twoInRDiag(Row, NewCol, Board, Value, NewPoints, FinalPoints)) ; twoInRDiag(Row, NewCol, Board, Value, Points, FinalPoints)).



twoInRDiag(Row, Col, Board, Value, Points, FinalPoints):-
	Col >= 6,
	Row < 6,
	NewRow is Row + 1,
	twoInRDiag(NewRow, 1, Board, Value, Points, FinalPoints).


twoInLDiag(2, 6,_,_, Points, FinalPoints):-
	FinalPoints = Points.


twoInLDiag(Row, Col, Board, Value, Points, FinalPoints):-
	Col < 6,
	Row > 1,
	NewRow is Row - 1,
	NewCol is Col + 1,
	getValueFromMatrix(Board, Row, Col,V1),
	getValueFromMatrix(Board, NewRow, NewCol, V2),
	((V1 == Value, V2 == Value) -> (NewPoints is Points+1, twoInLDiag(Row, NewCol, Board, Value, NewPoints, FinalPoints)) ; twoInLDiag(Row, NewCol, Board, Value, Points, FinalPoints)).


twoInLDiag(Row, Col, Board, Value, Points, FinalPoints):-
	Col >= 6,
	Row > 1,
	NewRow is Row-1,
	twoInLDiag(NewRow, 1, Board, Value, Points, FinalPoints).


twoInRow(_,0,0,_,_,CurrentPoints, FinalPoints):- FinalPoints = CurrentPoints.

twoInRow(Counter,Row,0,Board, Value, CurrentPoints, FinalPoints):- 
	NewRow is Row-1,
	twoInRow(0, NewRow, 6, Board, Value, CurrentPoints, FinalPoints).

twoInRow(Counter,Row,Col,Board,Value, CurrentP, Points):-
	(
		Counter =:= 2 -> (NewCounter is 0, NewCurrentP is CurrentP+1); 
		(NewCounter is Counter, NewCurrentP is CurrentP)
	),
    (
		getValueFromMatrix(Board,Row,Col,Value) -> NCounter is NewCounter+1; NCounter is 0
	),
	NewCol is Col-1,
	twoInRow(NCounter,Row,NewCol,Board,Value, NewCurrentP, Points).

directionalPoints(Board, Value, Points):-
	twoInRow(0, 6, 6, Board, Value, 0, PointsR),
	twoInCol(0, 6, 6, Board, Value, 0, PointsC),
	twoInRDiag(1, 1, Board, Value, 0, PointsRD),
	twoInLDiag(6, 1, Board, Value, 0, PointsLD),
	!,Points is PointsR+PointsC+PointsRD+PointsLD.

testWinMove(Value, CRow, CCol, Board, NewBoard):-
	incrementPos(1,1,CRow,CCol),
    verifyWinMove(Value, CRow, CCol, Board, NewBoard).

verifyWinMove(Value, Row, Col, Board, NewBoard):-
    getValueFromMatrix(Board, Row, Col, empty),
    replaceInMatrix(Board, Row, Col, Value, TempBoard),
    repulsions(TempBoard, NewBoard, Row, Col),
	checkAll(NewBoard, Value),!.