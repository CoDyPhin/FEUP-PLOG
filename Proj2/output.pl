printElemTimes(0, _).
printElemTimes(Num, Char):-
    write(Char),
    NNum is Num-1,
    printElemTimes(NNum, Char).

printRow([],_):- write('|'),nl.
printRow([Elem|Tail], Digits):-
    write('|'),
    countDigits(Elem, EDigs),
    Times is Digits - EDigs,
    printElemTimes(Times, ' '),
    write(Elem),
    printRow(Tail, Digits).


printRows([], _,Num):- write('|'),printElemTimes(Num,'-'),write('|'),nl.
printRows([Row|Tail], Digits, Num):-
    write('|'), printElemTimes(Num,'-'),write('|'),nl,
    printRow(Row, Digits),
    printRows(Tail, Digits, Num).

printPuzzle(Puzzle, Sum):-
    countDigits(Sum, Digits),
    nth1(1,Puzzle,Row),
    length(Row, Int),
    Num is Int*(Digits+1)-1, 
    printRows(Puzzle, Digits, Num).