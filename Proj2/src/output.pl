% Predicate that prints the character Char Num times

printElemTimes(0, _).
printElemTimes(Num, Char):-
    write(Char),
    NNum is Num-1,
    printElemTimes(NNum, Char).

% Predicate that prints a row of a puzzle with the correct spacing for the possible solutions

printRow([],_):- write('|'),nl.
printRow([Elem|Tail], Digits):-
    write('|'),
    countDigits(Elem, EDigs),
    Times is Digits - EDigs,
    printElemTimes(Times, ' '),
    write(Elem),
    printRow(Tail, Digits).

% Predicate that prints the rows of a puzzle

printRows([], _,Num):- write('|'),printElemTimes(Num,'-'),write('|'),nl.
printRows([Row|Tail], Digits, Num):-
    write('|'), printElemTimes(Num,'-'),write('|'),nl,
    printRow(Row, Digits),
    printRows(Tail, Digits, Num).

% Predicate that prints a puzzle

printPuzzle(Puzzle, Sum):-
    countDigits(Sum, Digits),
    nth1(1,Puzzle,Row),
    length(Row, Int),
    Num is Int*(Digits+1)-1, 
    printRows(Puzzle, Digits, Num).