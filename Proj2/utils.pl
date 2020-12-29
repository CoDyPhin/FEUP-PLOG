checkRowSum([],_).
checkRowSum([H|T], Sum):-
    sum(H, #=, Sum),
    checkRowSum(T, Sum).

checkInputPresence(Value, Number):-
    Value mod 10 #= Number.
checkInputPresence(Value, Number):-
    Value #> 0,
    Rest #= Value // 10,
    checkInputPresence(Rest, Number).

iterateRow([], _, _).
iterateRow([Val|T], PuzzleRow, Index):-
    nth1(Index, PuzzleRow, Number),
    checkInputPresence(Val, Number),
    NIndex is Index+1,
    iterateRow(T, PuzzleRow, NIndex).

iterateSol([], _).
iterateSol([Row|Tail], [PRow|PTail]):-
    iterateRow(Row, PRow, 1),
    iterateSol(Tail, PTail).

genList(AuxList, AuxList, 0, _, _).
genList(AuxList, SolutionList, NCols, NRows, Sum):-
    length(List, NRows),
    domain(List, 1, Sum),
    append(AuxList, [List], NAuxList),
    NNCols is NCols-1,
    genList(NAuxList, SolutionList, NNCols, NRows, Sum).
    

generateSolutionList(Puzzle, SolutionList, Sum):-
    length(Puzzle, NCols),
    nth1(1, Puzzle, Row),
    length(Row, NRows),
    genList([], SolutionList, NCols, NRows, Sum).

countDigs(0, Digits, Digits).
countDigs(Number, Digits, AuxDigs):-
    NNumber is Number // 10,
    NDigs is AuxDigs+1,
    countDigs(NNumber, Digits, NDigs).

countDigits(Number, Digits):-
    once(countDigs(Number, Digits, 0)).