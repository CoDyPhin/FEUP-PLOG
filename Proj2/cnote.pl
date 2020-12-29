:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- consult('utils.pl').
:- consult('output.pl').


solvePuzzle(Puzzle, Sum, SolutionList):-
    generateSolutionList(Puzzle, SolutionList, Sum),
    transpose(SolutionList, TSolutionList),
    checkRowSum(SolutionList, Sum),
    checkRowSum(TSolutionList, Sum),
    iterateSol(SolutionList, Puzzle),
    term_variables(SolutionList, Vars),
    labeling([], Vars).
    

cNote(Puzzle, Sum):-
    write('Puzzle: '), nl,
    printPuzzle(Puzzle, Sum),
    write('Solution: '), nl,
    solvePuzzle(Puzzle, Sum, Solution),
    once(printPuzzle(Solution, Sum)).
