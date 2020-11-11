flatten([], []) :- !.
flatten([L|Ls], FlatL) :-
    !,
    flatten(L, NewL),
    flatten(Ls, NewLs),
    append(NewL, NewLs, FlatL).
flatten(L, [L]).

getValueFromMatrix(Board, Row, Col, Value) :-
    nth1(Row, Board, NewRow),
    nth1(Col, NewRow, Value).

checkTopLeftDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row-1,
    NewCol is Column-1,
    NewRow > 0,
    NewCol > 0,
    getValueFromMatrix(Board,NewRow,NewCol,P),
    (P==empty->replaceInMatrix(Board,NewRow,NewCol,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,empty,UpdatedBoard);
    UpdatedBoard = Board).

checkTopLeftDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row-1,
    NewRow =< 0,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard);
    NewCol is Column-1,
    NewCol =< 0,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).

checkTopLeftDiagonal(N,Row,Column,Piece,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row-1,
    NewRow =< 0,
    UpdatedBoard = Board;
    NewCol is Column-1,
    NewCol =< 0,
    UpdatedBoard = Board.

checkTopLeftDiagonal(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row-1,
    NewCol is Column-1,
    NewRow > 0,
    NewCol > 0,
    NewN is N-1,
    getValueFromMatrix(Board,NewRow,NewCol,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkTopLeftDiagonal(NewN,NewRow,NewCol,Piece,Board,UpdatedBoard)).


checkUpperColumn(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row-1,
    NewRow > 0,
    getValueFromMatrix(Board,NewRow,Column,P),
    (P==empty->replaceInMatrix(Board,NewRow,Column,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,empty,UpdatedBoard);
    UpdatedBoard = Board).

checkUpperColumn(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row-1,
    NewRow =< 0,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).

checkUpperColumn(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row-1,
    NewRow > 0,
    NewN is N-1,
    getValueFromMatrix(Board,NewRow,Column,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkUpperColumn(NewN,NewRow,Column,Piece,Board,UpdatedBoard)).

checkUpperColumn(N,Row,Column,Piece,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row-1,
    NewRow =< 0,
    UpdatedBoard = Board.


checkTopRightDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row-1,
    NewRow > 0,
    NewCol is Column+1,
    NewCol < 7,
    getValueFromMatrix(Board,NewRow,NewCol,P),
    (P==empty->replaceInMatrix(Board,NewRow,NewCol,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,empty,UpdatedBoard);
    UpdatedBoard = Board).

checkTopRightDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row-1,
    NewRow =< 0,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard);
    NewCol is Column+1,
    NewCol >= 7,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).
    

checkTopRightDiagonal(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row-1,
    NewCol is Column+1,
    NewRow > 0,
    NewCol < 7,
    NewN is N-1,
    getValueFromMatrix(Board,NewRow,NewCol,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkTopRightDiagonal(NewN,NewRow,NewCol,Piece,Board,UpdatedBoard)).


checkTopRightDiagonal(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row-1,
    NewRow =< 0,
    UpdatedBoard = Board;
    NewCol is Column+1,
    NewCol >= 7,
    UpdatedBoard = Board.


checkRightRow(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewCol is Column+1,
    NewCol < 7,
    getValueFromMatrix(Board,Row,NewCol,P),
    (P==empty->replaceInMatrix(Board,Row,NewCol,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,empty,UpdatedBoard);
    UpdatedBoard = Board).

checkRightRow(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewCol is Column+1,
    NewCol >= 7,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).

checkRightRow(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewCol is Column+1,
    NewCol < 7,
    NewN is N-1,
    getValueFromMatrix(Board,Row,NewCol,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkRightRow(NewN,Row,NewCol,Piece,Board,UpdatedBoard)).

checkRightRow(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewCol is Column+1,
    NewCol >= 7,
    UpdatedBoard = Board.

checkBottomRightDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row+1,
    NewRow < 7,
    NewCol is Column+1,
    NewCol < 7,
    getValueFromMatrix(Board,NewRow,NewCol,P),
    (P==empty->replaceInMatrix(Board,NewRow,NewCol,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,empty,UpdatedBoard);
    UpdatedBoard = Board).

checkBottomRightDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row+1,
    NewRow >= 7,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard);
    NewCol is Column+1,
    NewCol >= 7,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).

checkBottomRightDiagonal(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row+1,
    NewRow < 7,
    NewCol is Column+1,
    NewCol < 7,
    NewN is N-1,
    getValueFromMatrix(Board,NewRow,NewCol,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkBottomRightDiagonal(NewN,NewRow,NewCol,Piece,Board,UpdatedBoard)).

checkBottomRightDiagonal(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row+1,
    NewRow >= 7,
    UpdatedBoard = Board;
    NewCol is Column+1,
    NewCol >= 7,
    UpdatedBoard = Board.

checkBottomColumn(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row+1,
    NewRow < 7,
    getValueFromMatrix(Board,NewRow,Column,P),
    (P==empty->replaceInMatrix(Board,NewRow,Column,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,empty,UpdatedBoard);
    UpdatedBoard = Board).

checkBottomColumn(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row+1,
    NewRow >= 7,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).

checkBottomColumn(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row+1,
    NewRow < 7,
    NewN is N-1,
    getValueFromMatrix(Board,NewRow,Column,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkBottomColumn(NewN,NewRow,Column,Piece,Board,UpdatedBoard)).

checkBottomColumn(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row+1,
    NewRow >= 7,
    UpdatedBoard = Board.

checkBottomLeftDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row+1,
    NewRow < 7,
    NewCol is Column-1,
    NewCol > 0,
    getValueFromMatrix(Board,NewRow,NewCol,P),
    (P==empty->replaceInMatrix(Board,NewRow,NewCol,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,0,UpdatedBoard);
    UpdatedBoard = Board).

checkBottomLeftDiagonal(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewRow is Row+1,
    NewRow >= 7,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard);
    NewCol is Column-1,
    NewCol =< 0,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).

checkBottomLeftDiagonal(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row+1,
    NewRow < 7,
    NewCol is Column-1,
    NewCol > 0,
    NewN is N-1,
    getValueFromMatrix(Board,NewRow,NewCol,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkBottomLeftDiagonal(NewN,NewRow,NewCol,Piece,Board,UpdatedBoard)).

checkBottomLeftDiagonal(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewRow is Row+1,
    NewRow >= 7,
    UpdatedBoard = Board;
    NewCol is Column-1,
    NewCol =< 0,
    UpdatedBoard = Board.


checkLefttRow(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewCol is Column-1,
    NewCol > 0,
    getValueFromMatrix(Board,Row,NewCol,P),
    (P==empty->replaceInMatrix(Board,Row,NewCol,Piece,UpdatedBoard1), replaceInMatrix(UpdatedBoard1,Row,Column,empty,UpdatedBoard);
    UpdatedBoard = Board).

checkLefttRow(0,Row,Column,Piece,Board,UpdatedBoard):-
    NewCol is Column-1,
    NewCol =< 0,
    replaceInMatrix(Board,Row,Column,empty,UpdatedBoard).

checkLefttRow(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewCol is Column-1,
    NewCol > 0,
    NewN is N-1,
    getValueFromMatrix(Board,Row,NewCol,Piece),
    (Piece==empty->UpdatedBoard = Board;
    checkLefttRow(NewN,Row,NewCol,Piece,Board,UpdatedBoard)).

checkLefttRow(N,Row,Column,P,Board,UpdatedBoard):-
    N > 0,
    NewCol is Column-1,
    NewCol =< 0,
    UpdatedBoard = Board.
    

repulsion(Row,Column,P,Board,UpdatedBoard):-
    checkTopLeftDiagonal(1,Row,Column,P,Board,UpdatedBoard1),
    checkUpperColumn(1,Row,Column,P,UpdatedBoard1,UpdatedBoard2),
    checkTopRightDiagonal(1,Row,Column,P,UpdatedBoard2,UpdatedBoard3),
    checkRightRow(1,Row,Column,P,UpdatedBoard3,UpdatedBoard4),
    checkBottomRightDiagonal(1,Row,Column,P,UpdatedBoard4,UpdatedBoard5),
    checkBottomColumn(1,Row,Column,P,UpdatedBoard5,UpdatedBoard6),
    checkBottomLeftDiagonal(1,Row,Column,P,UpdatedBoard6,UpdatedBoard7),
    checkLefttRow(1,Row,Column,P,UpdatedBoard7,UpdatedBoard).

     