% AI LEVEL 1

decideMove(Row, Col, Board):-
    random(1,7,RValue),
    random(1,7,CValue),
    ( 
        getValueFromMatrix(Board, RValue, CValue, empty) -> 
        (Col is CValue, Row is RValue, indexToCol(Col, ColString), write('PC played move '), write(ColString), write(Row), nl);
        decideMove(Row, Col, Board)
    ).