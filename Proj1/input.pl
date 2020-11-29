% Input reading and checking

readInput(NewRow, NewCol, ConfirmedR, ConfirmedC, Board):-
    (
        readColumn(_, NewCol) -> true; (!,fail)
    ),
    (
        readRow(_, NewRow) -> true; (!,fail)
    ),
    (
        getValueFromMatrix(Board, NewRow, NewCol, empty) -> 
            (ConfirmedC is NewCol, ConfirmedR is NewRow);
            (write('This position is already occupied. Select again:\n'),
            readInput(_, _, ConfirmedR, ConfirmedC, Board))
    ).

% Row reading and checking
readRow(R1, NewRow):-
    write('Row:\n'),
    read(R1),
    !,checkRow(R1, NewRow).

checkRow(1, 1).

checkRow(2, 2).

checkRow(3, 3).

checkRow(4, 4).

checkRow(5, 5).

checkRow(6, 6).

% Special cases for the pause menu
checkRow('pause', NewRow):-
    pauseMenu(Return),
    (
        Return =:= 1 -> readRow(_, NewRow); true
    ),
    (
        Return =:= 2 -> (!,fail); true
    ).

checkRow('P', NewRow):-
    pauseMenu(Return),
    (
        Return =:= 1 -> readRow(_, NewRow); true
    ),
    (
        Return =:= 2 -> (!,fail); true
    ).

checkRow(p, NewRow):-
    pauseMenu(Return),
    (
        Return =:= 1 -> readRow(_, NewRow); true
    ),
    (
        Return =:= 2 -> (!,fail); true
    ).

% Invalid Row that is not pause
checkRow(Input, NewRow) :-
    ((Input \= p, Input \= 'P', Input \= 'pause') -> (write('Invalid Row!\nSelect again:\n'),
    readRow(_, NewRow));fail).

% Column reading and checking
readColumn(C1, NewCol):-
    write('Column:\n'),
    read(C1),
    !,checkColumn(C1, NewCol).

checkColumn('A', 1).

checkColumn('B', 2).

checkColumn('C', 3).

checkColumn('D', 4).

checkColumn('E', 5).

checkColumn('F', 6).

checkColumn(a, 1).

checkColumn(b, 2).

checkColumn(c, 3).

checkColumn(d, 4).

checkColumn(e, 5).

checkColumn(f, 6).

% Special cases for pause menu
checkColumn('pause', NewCol):-
    pauseMenu(Return),
    (
        Return =:= 1 -> readColumn(_, NewCol); true
    ),
    (
        Return =:= 2 -> (!,fail); true
    ).

checkColumn('P', NewCol):-
    pauseMenu(Return),
    (
        Return =:= 1 -> readColumn(_, NewCol); true
    ),
    (
        Return =:= 2 -> (!,fail); true
    ).

checkColumn(p, NewCol):-
    pauseMenu(Return),
    (
        Return =:= 1 -> readColumn(_, NewCol); true
    ),
    (
        Return =:= 2 -> (!,fail); true
    ).

% Invalid Column that is not pause
checkColumn(Input, NewCol) :-
    ((Input \= p, Input \= 'P', Input \= 'pause') -> (write('Invalid Column!\nSelect again:\n'),
    readColumn(_, NewCol));fail).
