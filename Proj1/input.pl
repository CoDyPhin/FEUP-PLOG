readRow(R1, NewRow):-
    write('Row:\n'),
    read(R1),
    checkRow(R1, NewRow).

checkRow(1, NewRow) :-
    NewRow = 1.

checkRow(2, NewRow) :-
    NewRow = 2.

checkRow(3, NewRow) :-
    NewRow = 3.

checkRow(4, NewRow) :-
    NewRow = 4.

checkRow(5, NewRow) :-
    NewRow = 5.

checkRow(6, NewRow) :-
    NewRow = 6.

checkRow(_Row, NewRow) :-
    write('Invalid Row!\nSelect again:\n'),
    readRow(NewRow).


readColumn(C1, NewCol):-
    write('Column:\n'),
    read(C1),
    checkColumn(C1, NewCol).

checkColumn('A', NewCol) :-
    NewCol = 1.

checkColumn('B', NewCol) :-
    NewCol = 2.

checkColumn('C', NewCol) :-
    NewCol = 3.

checkColumn('D', NewCol) :-
    NewCol = 4.

checkColumn('E', NewCol) :-
    NewCol = 5.

checkColumn('F', NewCol) :-
    NewCol = 6.

checkColumn(a, NewCol) :-
    NewCol = 1.

checkColumn(b, NewCol) :-
    NewCol = 2.

checkColumn(c, NewCol) :-
    NewCol = 3.

checkColumn(d, NewCol) :-
    NewCol = 4.

checkColumn(e, NewCol) :-
    NewCol = 5.

checkColumn(f, NewCol) :-
    NewCol = 6.

checkColumn(_Column, NewColumn) :-
    write('Invalid Column!\nSelect again:\n'),
    readColumn(NewCol).


replaceInList([_H|T], 0, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
    Index > 0,
    Index1 is Index - 1,
    replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
    replaceInList(H, Column, Value, HNew).

replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
    Row > 0,
    Row1 is Row - 1,
    replaceInMatrix(T, Row1, Column, Value, TNew).