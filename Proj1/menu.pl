mainMenu:-
    displayMMenu,
    selectOption.


displayMMenu:-
    char_code(X, 256),
    nl,
    write('_________________________________________________________________\n'),
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|       '), write(' '), write(X), write(X), write(X), write(X), write(X), write(X), write('  '),write(X), write(X), write(X), write(X), write(X), write(X), write(X), write(' '),write(X), write(X), write('   '), write(X), write(X), write(' '),write(X), write(X), write(' '),write(X), write(X), write(X), write(X), write(X), write(X), write(X), write(X), write('  '),write(X), write(X), write(X), write(X), write(X), write('  '),write(X), write(X), write(' '),write('        |'),nl,
    write('|       '),write(X), write(X), write('       '),write(X), write(X), write('      '),write(X), write(X), write('  '),write(X), write(X), write('  '),write(X), write(X), write('    '),write(X), write(X), write('    '),write(X), write(X), write('   '),write(X), write(X), write(' '),write(X), write(X), write(' '),write('        |'),nl,
    write('|       '),write(X), write(X), write('   '),write(X), write(X), write(X), write(' '),write(X), write(X), write(X), write(X), write(X), write('   '),write(X), write(X), write(X), write(X), write(X), write('   '),write(X), write(X), write('    '),write(X), write(X), write('    '),write(X), write(X), write(X), write(X), write(X), write(X), write(X), write(' '),write(X), write(X), write(' '),write('        |'),nl,
    write('|       '),write(X), write(X), write('    '),write(X), write(X), write(' '),write(X), write(X), write('      '),write(X), write(X), write('  '),write(X), write(X), write('  '),write(X), write(X), write('    '),write(X), write(X), write('    '),write(X), write(X), write('   '),write(X), write(X), write(' '),write(X), write(X), write(' '),write('        |'),nl,
    write('|       '),write(' '),write(X), write(X), write(X), write(X), write(X), write(X), write('  '),write(X), write(X), write(X), write(X), write(X), write(X), write(X), write(' '),write(X), write(X), write('   '),write(X), write(X), write(' '),write(X), write(X), write('    '),write(X), write(X), write('    '),write(X), write(X), write('   '),write(X), write(X), write(' '),write(X), write(X), write(' '),write('        |'),nl,
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|_______________________________________________________________|\n'),
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|                 1. Play Player vs Player                      |\n'),
    write('|                 2. Play Player vs PC                          |\n'),
    write('|                 3. Play PC vs PC                              |\n'),
    write('|                 0. Exit                                       |\n'),
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|_______________________________________________________________|\n').

selectOption:-
    write('Option: '),
    read(Option), nl,
    manageOption(Option).

selectDiff(BotStr):-
    write('Option: '),
    read(Option3), nl,
    manageDiff(Option3, BotStr).

manageDiff(1, 'B1').

manageDiff(2, 'B2').

manageDiff(_,BotStr):-
    write('Wrong option, choose a number from 1 to 2.'),nl,
    selectDiff(BotStr).


manageOption(0):- write('Exiting...\n').

manageOption(1):- play('P1', 'P2').

manageOption(2):- 
    write('PC1 Difficulty: [1] Easy    [2] Hard\n Option: '),
    selectDiff(BotStr),
    play('P1', BotStr).

manageOption(3):- 
    write('PC1 Difficulty: [1] Easy    [2] Hard\n'),
    selectDiff(BotStr),
    write('PC2 Difficulty: [1] Easy    [2] Hard\n'),
    selectDiff(BotStr2),
    play(BotStr, BotStr2).

manageOption(_):-
    write('Wrong option, choose a number from 0 to 3.'),nl,
    selectOption.


pauseMenu(Return):-
    displayPMenu,
    selectOption2(Return).

displayPMenu:-
    write('_________________________________________________________________\n'),
    write('|                                                               |\n'),
    write('|                                                               |\n'),
    write('|                      Game Paused                              |\n'),
    write('|                                                               |\n'),
    write('|                      1. Resume                                |\n'),
    write('|                      2. Return to Main Menu                   |\n'),
    write('|                      0. Exit game                             |\n'),
    write('|                                                               |\n'),
    write('|_______________________________________________________________|\n').

selectOption2(Return):-
    write('Option: '),
    read(Option2), nl,!,
    manageOption2(Option2, Return).

manageOption2(0, _):-
    abort.

manageOption2(1, 1).

manageOption2(2, 2).

manageOption2(_,Return):-
    write('Wrong option, choose a number from 0 to 2.'),nl,
    selectOption2(Return).
 