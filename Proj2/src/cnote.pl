:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- consult('stats.pl').
:- consult('utils.pl').
:- consult('output.pl').

% Predicate that generates a puzzle of Size rows and Size columns with sum Sum each, unifying Puzzle with the Puzzle input and SPuzzle with the solution

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

% Predicate that solves the puzzle Puzzle for sum Sum and unifies SolutionList with the solution

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
    
% User predicate that receives the Size and the Sum and prints the generated puzzle and the corresponding solution

generate(Size, Sum):-
    generatePuzzle(Size, Sum, Puzzle, Solution),
    write('Generated Puzzle: '),nl,
    printPuzzle(Puzzle, Sum),
    write('Solution: '), nl,!,
    once(printPuzzle(Solution, Sum)).


% User predicate that receives the Puzzle and the Sum and prints the given puzzle and the corresponding solution

solver(Puzzle, Sum):-
    write('Puzzle: '), nl,
    printPuzzle(Puzzle, Sum),
    write('Solution: '), nl,!,
    solvePuzzle(Puzzle, Sum, Solution),
    once(printPuzzle(Solution, Sum)).
