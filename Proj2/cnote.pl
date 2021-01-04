:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- consult('stats.pl').
:- consult('utils.pl').
:- consult('output.pl').

generatePuzzle(Size, Sum, Puzzle, SPuzzle):-
    reset_timer,
    genList([], SPuzzle, Size, Size, Sum),
    transpose(SPuzzle, TPuzzle),
    checkRowSum(SPuzzle, Sum),
    checkRowSum(TPuzzle, Sum),
    term_variables(SPuzzle, Vars),
    !,
    labeling([value(randomLabelingValues)], Vars),
    unsolvePuzzle(SPuzzle, [], Puzzle),
    fd_statistics,
    print_time.

solvePuzzle(Puzzle, Sum, SolutionList):-
    reset_timer,
    generateSolutionList(Puzzle, SolutionList, Sum),
    transpose(SolutionList, TSolutionList),
    checkRowSum(SolutionList, Sum),
    checkRowSum(TSolutionList, Sum),
    iterateSol(SolutionList, Puzzle),
    term_variables(SolutionList, Vars),
    labeling([], Vars),
    fd_statistics,
    print_time.
    
generate(Size, Sum):-
    generatePuzzle(Size, Sum, Puzzle, Solution),
    write('Generated Puzzle: '),nl,
    printPuzzle(Puzzle, Sum),
    write('Solution: '), nl,!,
    once(printPuzzle(Solution, Sum)).

solver(Puzzle, Sum):-
    write('Puzzle: '), nl,
    printPuzzle(Puzzle, Sum),
    write('Solution: '), nl,!,
    solvePuzzle(Puzzle, Sum, Solution),
    once(printPuzzle(Solution, Sum)).
