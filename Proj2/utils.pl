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

genList(SolutionList, SolutionList, 0, _, _).
genList(AuxList, SolutionList, NCols, NRows, Sum):-
    length(List, NRows),
    domain(List, 1, Sum),
    append(AuxList, [List], NAuxList),
    NNCols is NCols-1,
    NNCols >= 0,
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


numToList(NUM,[LIST|[]]):-
    NUM < 10,
    LIST is NUM,
    !.
 numToList(NUM,LIST):-
    P is NUM // 10,
    numToList(P,LIST1),
    END is (NUM mod 10), 
    append(LIST1,[END] ,LIST).

listToNum([],Number,Number).
listToNum([H|T], Number, Num):-
    length([H|T], Size),
    Size > 0,
    NNumber is Number + H*(10^(Size-1)),
    listToNum(T, NNumber, Num).


remDigit(0, List, NewList):-      % 0 for first; 1 for last
    nth0(0, List, Elem),
    select(Elem, List, AuxList),!,
    ( sumlist(AuxList, 0) -> 
        remDigit(1, List, NewList);
        NewList = AuxList 
    ).

remDigit(1, List, NewList):-
    reverse(List, AuxList),
    nth0(0, AuxList, Elem),
    select(Elem, AuxList, AAuxList),!,
    reverse(AAuxList, NewList).
    

 removeDigit(Number, NewNumber):-
    numToList(Number, List),
    length(List, Int),
    random(0,2,Random),
    (Int =:= 1 -> 
        NewNumber is Number; 
        (remDigit(Random, List, NewList),
        listToNum(NewList, 0, NewNumber)
        )
    ).
    
    
randomLabelingValues(Var, _Rest, BB, BB1) :-
    fd_set(Var, Set),
    select_best_value(Set, Value),
    (   
        first_bound(BB, BB1), Var #= Value
        ;   
        later_bound(BB, BB1), Var #\= Value
    ),!.

select_best_value(Set, BestValue):-
    fdset_to_list(Set, Lista),
    length(Lista, Len),
    random(0, Len, RandomIndex),
    nth0(RandomIndex, Lista, BestValue).

unsolveRow([], Row, Row).
unsolveRow([H|T], AuxRow, UnsolvedRow):-
    removeDigit(H, Num),
    append(AuxRow, [Num], NAuxRow),
    unsolveRow(T, NAuxRow, UnsolvedRow).

unsolvePuzzle([],R,R).
unsolvePuzzle([Row|T],AuxResult, Result):-
    unsolveRow(Row, [], UnsolvedRow),
    append(AuxResult, [UnsolvedRow], NAuxResult),
    unsolvePuzzle(T, NAuxResult, Result).
