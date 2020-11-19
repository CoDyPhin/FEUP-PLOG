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

manageOption(0):- write('Exiting...\n').

manageOption(1):- play('P1', 'P2').

manageOption(2):- play('P1', 'PC1').

manageOption(3):- play('PC1', 'PC2').

manageOption(_):-
    write('Wrong option, choose a number from 0 to 3.'),nl,
    selectOption.

                                
 