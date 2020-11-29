% AI LEVEL 2

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

verifyMove(2, Row, Col, Board, NewBoard):-
    getValueFromMatrix(Board, Row, Col, empty),
    replaceInMatrix(Board, Row, Col, plyr2, TempBoard),
    repulsions(TempBoard, NewBoard, Row, Col),!.

verifyMove(1, Row, Col, Board, NewBoard):-
    getValueFromMatrix(Board, Row, Col, empty),
    replaceInMatrix(Board, Row, Col, plyr1, TempBoard),
    repulsions(TempBoard, NewBoard, Row, Col),!.

testMove(Player, CRow, CCol, Board, NewBoard):-
    incrementPos(1,1,CRow,CCol),
    verifyMove(Player, CRow, CCol, Board, NewBoard).

value(GameState, Player, Value):-
    (Player =:= 1 -> (Piece = plyr1, OpPiece = plyr2); (Player =:= 2 -> (Piece = plyr2, OpPiece = plyr1);fail)),
    (
        checkAll(GameState, Piece) -> Points1 is 100; Points1 is 0
    ),
    (
        checkAll(GameState, OpPiece) -> Points2 is 100; Points2 is 0
    ),
    flatten(GameState, FlatBoard),
    piecesOnBoard(FlatBoard, 1, OpPiece, 0, Points3),
    piecesOnBoard(FlatBoard, 1, Piece, 0, Points4),
    directionalPoints(GameState, OpPiece, Points5),
    directionalPoints(GameState, Piece, Points6),
    ( (Points3 > 2, Points1 < 100, Points2 < 100) -> ( testWinMove(OpPiece, _, _, GameState, _) -> Points7 is 100; Points7 is 0); Points7 is 0),
    Value is Points1-Points2-(2*Points3)+Points4-(20*Points5)+(5*Points6)-Points7,
iterateMoveList([],NewEvaluatedMatrix,_,NewEvaluatedMatrix).

iterateMoveList([H|T], EvaluatedMatrix, 2, FinalMatrix):-
    nth1(1,H,Row),
    nth1(2,H,Col),
    nth1(3,H,Board),
    value(Board, 2, Points),
    append(EvaluatedMatrix, [[Row,Col,Points]],NewEvaluatedMatrix),
    iterateMoveList(T,NewEvaluatedMatrix,2,FinalMatrix).

iterateMoveList([H|T], EvaluatedMatrix, 1, FinalMatrix):-
    nth1(1,H,Row),
    nth1(2,H,Col),
    nth1(3,H,Board),
    value(Board, 1, Points),
    append(EvaluatedMatrix, [[Row,Col,Points]],NewEvaluatedMatrix),
    iterateMoveList(T,NewEvaluatedMatrix,1,FinalMatrix).

selectBestMoves(_,BMList,[],BMList).

selectBestMoves(BMPoints, BMList, [H|T], BestMoves):-
    nth1(3,H,Points),
    (
        BMPoints < Points -> selectBestMoves(Points, [H] ,T, BestMoves);
        (
            (
                BMPoints =:= Points -> (append(BMList, [H], NewBMList), selectBestMoves(BMPoints, NewBMList, T, BestMoves)); 
                selectBestMoves(BMPoints, BMList, T, BestMoves)
            )
        )
    ).

valid_moves(GameState, Player, ListOfMoves):-
    findall([CRow, CCol, NewBoard], testMove(Player, CRow, CCol, GameState, NewBoard), ListOfMoves).

choose_move(GameState, Player, 2, Move):-
    valid_moves(GameState, Player, MoveList),
    iterateMoveList(MoveList, [], Player, EvalMatrix),
    selectBestMoves(-200, [], EvalMatrix, BestMoves),
    length(BestMoves, MaxIndex),
    random(0,MaxIndex, Index),
    nth0(Index, BestMoves, AMove),
    nth0(0,AMove,BMRow),
    nth0(1,AMove,BMCol),
    indexToCol(BMCol, ColString), write('PC played move '), write(ColString), write(BMRow),nl,
    Move = [BMRow, BMCol, Player].

% AI LEVEL 1

choose_move(GameState, Player, 1, Move):-
    random(1,7,RValue),
    random(1,7,CValue),
    ( 
        getValueFromMatrix(GameState, RValue, CValue, empty) -> 
        (Move = [CValue, RValue, Player], indexToCol(CValue, ColString), write('PC played move '), write(ColString), write(RValue), nl);
        choose_move(GameState, Player, 1, Move)
    ).