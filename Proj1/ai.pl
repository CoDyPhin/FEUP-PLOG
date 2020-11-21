% AI LEVEL 1

decideMove(Row, Col, Board):-
    random(1,7,RValue),
    random(1,7,CValue),
    ( 
        getValueFromMatrix(Board, RValue, CValue, empty) -> 
        (Col is CValue, Row is RValue, indexToCol(Col, ColString), write('PC played move '), write(ColString), write(Row), nl);
        decideMove(Row, Col, Board)
    ).

incrementPos(IRow,ICol,CRow,CCol):- 
    CRow is IRow, 
    CCol is ICol.

incrementPos(IRow,ICol,CRow,CCol):-
    ICol < 7,
    IRow < 7,
    NewICol is ICol + 1,
    incrementPos(IRow,NewICol,CRow,CCol).

incrementPos(IRow,ICol,CRow,CCol):-
    ICol >= 7,
    IRow < 7,
    NewICol is 1,
    NewIRow is IRow + 1,
    incrementPos(NewIRow,NewICol,CRow,CCol).

verifyMove(Player, Row, Col, Board, NewBoard):-
    getValueFromMatrix(Board, Row, Col, empty),
    (   Player =:= 1 -> 
        replaceInMatrix(Board, Row, Col, plyr1, TempBoard)
    ;   Player =:= 2 ->
        replaceInMatrix(Board, Row, Col, plyr2, TempBoard)
    ),
    repulsions(TempBoard, NewBoard, Row, Col),!.

testMove(Player, CRow, CCol, Board, NewBoard):-
    incrementPos(1,1,CRow,CCol),
    verifyMove(Player, CRow, CCol, Board, NewBoard).

iterateMoveList([],NewEvaluatedMatrix,_,FinalMatrix):- FinalMatrix = NewEvaluatedMatrix.

iterateMoveList([H|T], EvaluatedMatrix, Player, FinalMatrix):-
    (   Player =:= 1 -> (Value = plyr1, OpValue = plyr2);
        Player =:= 2 -> (Value = plyr2, OpValue = plyr1)
    ),
    nth1(1,H,Row),
    nth1(2,H,Col),
    nth1(3,H,Board),
    (
        checkAll(Board, Value) -> Points1 is 100; Points1 is 0
    ),
    (
        checkAll(Board, OpValue) -> Points2 is 100; Points2 is 0
    ),
    flatten(Board, FlatBoard),
    piecesOnBoard(FlatBoard, 1, OpValue, 0, Points3),
    piecesOnBoard(FlatBoard, 1, Value, 0, Points4),
    directionalPoints(Board, OpValue, Points5),
    directionalPoints(Board, Value, Points6),
    Points is Points1-Points2-(2*Points3)+Points4-(20*Points5)+(5*Points6),
    append(EvaluatedMatrix, [[Row,Col,Points]],NewEvaluatedMatrix),
    iterateMoveList(T,NewEvaluatedMatrix,Player,FinalMatrix).

selectBestMoves(_,BMList,[],BestMoves):- BestMoves = BMList.

selectBestMoves(BMPoints, BMList, [H|T], BestMoves):-
    nth1(3,H,Points),
    nth1(1,H,FRow),
    nth1(2,H,FCol),
    (
        BMPoints < Points -> selectBestMoves(Points, [H] ,T, BestMoves);
        (
            (
                BMPoints =:= Points -> (append(BMList, [H], NewBMList), selectBestMoves(BMPoints, NewBMList, T, BestMoves)); 
                selectBestMoves(BMPoints, BMList, T, BestMoves)
            )
        )
    ).


findBestMove(Player, Board, BMRow, BMCol):-
    findall([CRow, CCol, NewBoard], testMove(Player, CRow, CCol, Board, NewBoard), MoveList),
    iterateMoveList(MoveList, [], Player, EvalMatrix),
    nl, write(EvalMatrix), nl,
    selectBestMoves(-200, [], EvalMatrix, BestMoves),
    length(BestMoves, MaxIndex),
    random(0,MaxIndex, Index),
    nth0(Index, BestMoves, Move),
    nth0(0,Move,BMRow),
    nth0(1,Move,BMCol),
    indexToCol(BMCol, ColString), write('PC played move '), write(ColString), write(BMRow),nl.