:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

:- consult('utils.pl').
:- consult('output.pl').

generatePuzzle(Size, Sum, Puzzle, SPuzzle):-
    genList([], SPuzzle, Size, Size, Sum),
    transpose(SPuzzle, TPuzzle),
    checkRowSum(SPuzzle, Sum),
    checkRowSum(TPuzzle, Sum),
    term_variables(SPuzzle, Vars),
    !,
    labeling([value(randomLabelingValues)], Vars),
    unsolvePuzzle(SPuzzle, [], Puzzle).

solvePuzzle(Puzzle, Sum, SolutionList):-
    generateSolutionList(Puzzle, SolutionList, Sum),
    transpose(SolutionList, TSolutionList),
    checkRowSum(SolutionList, Sum),
    checkRowSum(TSolutionList, Sum),
    iterateSol(SolutionList, Puzzle),
    term_variables(SolutionList, Vars),
    labeling([], Vars).
    
cNote('generate', Size, Sum):-
    generatePuzzle(Size, Sum, Puzzle, Solution),
    write('Generated Puzzle: '),nl,
    printPuzzle(Puzzle, Sum),
    write('Solution: '), nl,!,
    once(printPuzzle(Solution, Sum)).

cNote(Puzzle, Sum):-
    write('Puzzle: '), nl,
    printPuzzle(Puzzle, Sum),
    write('Solution: '), nl,!,
    solvePuzzle(Puzzle, Sum, Solution),
    once(printPuzzle(Solution, Sum)).
