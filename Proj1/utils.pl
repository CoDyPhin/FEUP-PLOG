% Gets printable Column from Col number
indexToCol(ColNum, ColString):-
	nth1(ColNum, ['A','B','C','D','E','F'], ColString).

% Flatten a list of lists
flatten([], []) :- !.
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten(L, [L]).

% Plays the piece in the chosen position (changing the matrix value)
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

% Gets the Value in a given position of the matrix
getValueFromMatrix(Board, Row, Col, Value) :-
    Row > 0,
    Col > 0,
    nth1(Row, Board, NewRow),
    nth1(Col, NewRow, Value).

% REPULSIONS

checkUpLeftPiece(Board,Board,1,_).

checkUpLeftPiece(Board,Board,_,1).

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


checkUpPiece(Board, Board, 1, _).

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


checkUpRightPiece(Board, Board, 1, _).

checkUpRightPiece(Board, Board, _, 6).

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

checkRightPiece(Board, Board, _, 6).

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
    

checkDownRightPiece(Board, Board, 6, _).

checkDownRightPiece(Board, Board, _, 6).

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

checkDownPiece(Board, Board, 6, _).

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

checkDownLeftPiece(Board, Board, 6, _).

checkDownLeftPiece(Board, Board, _, 1).

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

checkLeftPiece(Board, Board, _, 1).

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
     
% BOARD EVALUATION PREDICATES

% Counts how many pieces are on board
piecesOnBoard(_,37,_,Counter,Counter).

piecesOnBoard(Board, Index, Value, Counter, Points):-
    NewI is Index+1,
    (
        nth1(Index, Board, Value) -> NewC is Counter+1; NewC is Counter
    ),
    piecesOnBoard(Board, NewI, Value, NewC, Points),!.

% Counts how many vertical two in a rows are on board
twoInCol(_,0,0,_,_,CurrentPoints, CurrentPoints).

twoInCol(_,0,Col,Board, Value, CurrentPoints, FinalPoints):- 
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

% Counts how many right diagonal two in a rows are on board
twoInRDiag(5,6,_,_, Points, Points).

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

% Counts how many left diagonal two in a rows are on board
twoInLDiag(2, 6,_,_, Points, Points).

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

% Counts how many horizontal two in a rows are on board
twoInRow(_,0,0,_,_,CurrentPoints, FinalPoints):- FinalPoints = CurrentPoints.

twoInRow(_,Row,0,Board, Value, CurrentPoints, FinalPoints):- 
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

% Counts how many two in a rows are on board in all directions
directionalPoints(Board, Value, Points):-
	twoInRow(0, 6, 6, Board, Value, 0, PointsR),
	twoInCol(0, 6, 6, Board, Value, 0, PointsC),
	twoInRDiag(1, 1, Board, Value, 0, PointsRD),
	twoInLDiag(6, 1, Board, Value, 0, PointsLD),
	!,Points is PointsR+PointsC+PointsRD+PointsLD.

% Finds winning moves
testWinMove(Value, CRow, CCol, Board, NewBoard):-
	incrementPos(1,1,CRow,CCol),
    verifyWinMove(Value, CRow, CCol, Board, NewBoard).

verifyWinMove(Value, Row, Col, Board, NewBoard):-
    getValueFromMatrix(Board, Row, Col, empty),
    replaceInMatrix(Board, Row, Col, Value, TempBoard),
    repulsions(TempBoard, NewBoard, Row, Col),
	checkAll(NewBoard, Value),!.