play :-
    initialBoard(Board),
    printBoard(Board),
    startLoop(Board).

startLoop(Board):-
    p1Turn(Board, NewBoard),
    startLoop(NewBoard).

p1Turn(Board, NewBoard):-
    readRow(R1),
    readColumn(C1),
    RowIndex is R1 - 1,
    ColumnIndex is C1 - 1,
    replaceInMatrix(Board, RowIndex, ColumnIndex, p1, NewBoard),
    printBoard(NewBoard).

p2Turn(Board, NewBoard):-
    readRow(R2),
    readColumn(C2),
    RowIndex2 is R2 - 1,
    ColumnIndex2 is C2 - 1,
    replaceInMatrix(Board, RowIndex2, ColumnIndex2, p2, NewBoard),
    printBoard(NewBoard).
