% Predicate that applies the sum restriction for all rows

checkRowSum([],_).
checkRowSum([H|T], Sum):-
    sum(H, #=, Sum),
    checkRowSum(T, Sum).
 
 % Predicate that applies the user digit presence restriction

checkInputPresence(Value, Number):-
    /*constraintCountDigits(Value, Size),
    Size #> 0,
    NSize #= Size-1,
    pow(10,NSize,Exp),
    Value mod Exp #= Number.*/
    Value mod 10 #= Number.
checkInputPresence(Value, Number):-
    Value #> 0,
    Rest #= Value // 10,
    checkInputPresence(Rest, Number).

% Auxiliary predicate to iterate the rows of the solution list and apply the input digit presence restriction

iterateRow([], _, _).
iterateRow([Val|T], PuzzleRow, Index):-
    nth1(Index, PuzzleRow, Number),
    checkInputPresence(Val, Number),
    NIndex is Index+1,
    iterateRow(T, PuzzleRow, NIndex).

% Predicate that iterates the solution list to apply the input digit presence

iterateSol([], _).
iterateSol([Row|Tail], [PRow|PTail]):-
    iterateRow(Row, PRow, 1),
    iterateSol(Tail, PTail).

% Auxiliary predicate that generates the solution matrix with the decision variables necessasry

genList(SolutionList, SolutionList, 0, _, _).
genList(AuxList, SolutionList, NCols, NRows, Sum):-
    length(List, NRows),
    domain(List, 1, Sum),
    append(AuxList, [List], NAuxList),
    NNCols is NCols-1,
    NNCols >= 0,
    genList(NAuxList, SolutionList, NNCols, NRows, Sum).
    
% Predicate that generates the solution matrix with the decision variables necessasry

generateSolutionList(Puzzle, SolutionList, Sum):-
    length(Puzzle, NCols),
    nth1(1, Puzzle, Row),
    length(Row, NRows),
    genList([], SolutionList, NCols, NRows, Sum).

% Auxiliary predicate to count digits in a number

countDigs(0, Digits, Digits).
countDigs(Number, Digits, AuxDigs):-
    NNumber is Number // 10,
    NDigs is AuxDigs+1,
    countDigs(NNumber, Digits, NDigs).

% Predicate to count digits in a number

countDigits(Number, Digits):-
    once(countDigs(Number, Digits, 0)).

/*constraintCountDigs(0, Digits, Digits).
constraintCountDigs(Number, Digits, AuxDigs):-
    NNumber #= Number // 10,
    NDigs #= AuxDigs+1,
    constraintCountDigs(NNumber, Digits, NDigs).

constraintCountDigits(Number, Digits):-
    Number #>= 0,
    constraintCountDigs(Number, Digits, 0).

powAux(_, Num, 0, Num).
powAux(Num, Num2, Exp, Result):-
    NNum #= Num2 * Num,
    NExp #= Exp-1,
    powAux(Num, NNum, NExp, Result).

pow(_,0,1).
pow(Num, Exp, Result):-
    powAux(Num, 1, Exp, Result),!.*/


% Predicate that converts a number to a list of digits

numToList(NUM,[LIST|[]]):-
    NUM < 10,
    LIST is NUM,
    !.
 numToList(NUM,LIST):-
    P is NUM // 10,
    numToList(P,LIST1),
    END is (NUM mod 10), 
    append(LIST1,[END] ,LIST).

% Predicate that converts a list of digits to a number

listToNum([],Number,Number).
listToNum([H|T], Number, Num):-
    length([H|T], Size),
    Size > 0,
    NNumber is Number + H*(10^(Size-1)),
    listToNum(T, NNumber, Num).

% Auxiliary predicates to remove digits from a number

remDigit(0, List, NewList):-      % 0 to remove right-most digits; 1 to remove left-most digits
    nth0(0, List, Elem),
    append([],[Elem],NewList).

remDigit(1, List, NewList):-
    reverse(List, AuxList),
    nth0(0, AuxList, Elem),
    (
        Elem =:= 0 -> remDigit(0,List,NewList); append([],[Elem],NewList)
    ).    

% Predicate that randomly removes right-most or left-most digits

 removeDigits(Number, NewNumber):-
    numToList(Number, List),
    length(List, Int),
    random(0,2,Random),
    (Int =:= 1 -> 
        NewNumber is Number; 
        (remDigit(Random, List, NewList),
        listToNum(NewList, 0, NewNumber)
        )
    ).
    
% Random labeling values predicate (adapted from stackoverflow code)

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

% Predicate that unsolves a row by removing extra digits randomly

unsolveRow([], Row, Row).
unsolveRow([H|T], AuxRow, UnsolvedRow):-
    removeDigits(H, Num),
    append(AuxRow, [Num], NAuxRow),
    unsolveRow(T, NAuxRow, UnsolvedRow).

% Predicate that unsolves a solved puzzle

unsolvePuzzle([],R,R).
unsolvePuzzle([Row|T],AuxResult, Result):-
    unsolveRow(Row, [], UnsolvedRow),
    append(AuxResult, [UnsolvedRow], NAuxResult),
    unsolvePuzzle(T, NAuxResult, Result).
