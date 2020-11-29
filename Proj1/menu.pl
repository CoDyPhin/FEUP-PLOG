% Main Menu

mainMenu:-
    displayMMenu,
    selectOption.

% Main Menu Display
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

% Main Menu Option Handler
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

manageOption(1):- playGame('P1', 'P2').

manageOption(2):- 
    write('PC1 Difficulty: [1] Easy    [2] Hard\n'),
    selectDiff(BotStr),
    playGame('P1', BotStr).

manageOption(3):- 
    write('PC1 Difficulty: [1] Easy    [2] Hard\n'),
    selectDiff(BotStr),
    write('PC2 Difficulty: [1] Easy    [2] Hard\n'),
    selectDiff(BotStr2),
    playGame(BotStr, BotStr2).

manageOption(_):-
    write('Wrong option, choose a number from 0 to 3.'),nl,
    selectOption.

% Pause Menu
pauseMenu(Return):-
    displayPMenu,
    selectOption2(Return).

% Pause Menu Display
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

% Pause Menu Options Handler
selectOption2(Return):-
    write('Option: '),
    read(Option2), nl,!,
    manageOption2(Option2, Return),!.

manageOption2(0, _):-
    abort.

manageOption2(1, 1).

manageOption2(2, 2).

manageOption2(Input,Return):-
    ((Input \= 1, Input \= 2) -> (write('Wrong option, choose a number from 0 to 2.'),nl,
    selectOption2(Return)); true).
 
% Return to Main Menu Option Handler
checkMMenuInput:-
    write('Return to main menu? [0] No    [1] Yes\n'),
    read(Input),
    manageInput(Input).

manageInput(0):- write('Exiting...\n').

manageInput(1):- mainMenu.

manageInput(_):- 
    write('Wrong option!\n Return to main menu? [0] No    [1] Yes\n'), 
    read(NewInput), 
    manageInput(NewInput).