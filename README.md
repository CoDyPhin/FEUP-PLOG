# PLOG 2020/2021 - TP1

## Group: T04_Gekitai5

| Name             | Number    | E-Mail                |
| ---------------- | --------- | --------------------- |
|   Carlos Lousada  | 201806302 | up201806302@fe.up.pt  |
|  José David Rocha   | 201806371 | up201806371@fe.up.pt  |

## Installation and Execution

In order to run our game follow the following steps:

- Install and run SICStus Prolog.
- Go to File > Working Directory and navigate to the *Proj1* folder where you downloaded the code.
- Go to File > Consult and select the file [*gekitai.pl*](/Proj1/gekitai.pl).
- **Alternatively:** run `consult('path\to\gekitai.pl').`
- Type `play.` into the SICStus console and the game will start.

## Gekitai

- Game description:

    - Gekitai (Repel or Push Away) is a 2-person abstract strategy game.
    - Each player has eight colored markers and takes turns placing them anywhere on any open space on the board.
    - When placed, a marker pushes all adjacent pieces outwards one space if there is an open space for it to move to (or off the board).
    - Markers shoved off the board are returned to the player.
    - If there is not an open space on the opposite side of the pushed marker, it does not push
    - The first player to either line up three of their markers in a row at the end of their turn (after pushing) OR have all eight of their markers on the board (also after pushing), is declared the winner.

- Material:
    - A 6×6 board;
    - 16 markers (8 of each color, or, in this case, 'X's and an 'O's).

[Source](https://boardgamegeek.com/boardgame/295449/gekitai)

# Game Logic

## Internal representation of the game state

**Board**

- The board is represented by a list of lists (also referred as a matrix), where each element represents a row. Each row contains 6 elements (one for each column), which represents an empty space, a Player 1 marker or a Player 2 marker (empty, plyr1, plyr2 respectively)

**Player**

- Each atom can either represent a player's marker or an empty space.
  - Player 1's marker is represented by an 'X';
  - Player 2's marker is represented by an 'O';
  - An empty space is represented by ' '.
- The current player to move is displayed, as 'Player 1' or 'Player 2', in the display_game predicate.

**Game Loop**

- In Gekitai, the game starts off with Player 1's move, followed by Player 2's move. Both players take turns until the end of the game.
- Game Loop's Processing:
  - Initially, the predicate initial(GameState) is called in order to initialize an empty board, while also asserting the board's state and Player 1 as first one to move;
  - The board's state is displayed;
  - The predicate playMove is called, which is responsible for verifying if the Player's given move is valid and, if so, replacing the necessary values in the matrix  (which also includes repulsions);
  - The next Player to move is asserted as well as the new game state;
  - The predicate checkVictory is called, which is responsible for verifying if the loop was interrupted by the Pause Menu, as well as checking if and which of the players won. 
- The loop repeats itself until the predicate checkVictory does not fail, meaning either one of the players won the game or it was simply interrupted by the Pause Menu.
- When the game ends the predicate endGame is called, which retracts the previous game state, allowing for a new one to start. Furthermore, it also displays the final board alongside with the winner of the game. If the game was interrupted by the Pause Menu, the Main Menu is called, otherwise the user will be prompted whether or not the program should return to the Main Menu.

**Game States**

- Initial Situation:

```
   initialBoard([
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    [empty,empty,empty,empty,empty,empty],
    ]). 
```
       | A | B | C | D | E | F |
    ---|---|---|---|---|---|---|
     1 |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     2 |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     3 |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     4 |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     5 |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     6 |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
    Player 1 Move:
    Col:
    |: 


- Intermediate Situation:

```
    intermediateBoard([  
    [empty,empty,plyr1,empty,plyr1,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [plyr2,empty,empty,plyr1,empty,empty],  
    [empty,empty,empty,empty,plyr2,plyr1],  
    [empty,plyr2,empty,empty,empty,empty],  
    [empty,empty,empty,empty,plyr2,empty]  
    ]).
```

        | A | B | C | D | E | F |  
     ---|---|---|---|---|---|---|  
      1 |   |   | X |   | X |   |  
     ---|---|---|---|---|---|---|  
      2 |   |   |   | O |   | X |  
     ---|---|---|---|---|---|---|  
      3 | O |   |   | X |   |   |  
     ---|---|---|---|---|---|---|  
      4 |   |   |   |   | O | X |  
     ---|---|---|---|---|---|---|  
      5 |   | X | O |   |   |   |  
     ---|---|---|---|---|---|---|  
      6 | O |   |   |   | O |   |  
     ---|---|---|---|---|---|---|  
     Player 1 Move:
     Col:
     |:


- Final Situation:

```
  finalBoard([  
    [plyr1,empty,empty,plyr1,empty,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [empty,plyr2,plyr2,plyr2,plyr1,empty],  
    [empty,empty,empty,empty,empty,empty],  
    [plyr2,empty,plyr1,plyr1,empty,empty],  
    [empty,empty,empty,empty,empty,plyr2]  
    ]).
```

        | A | B | C | D | E | F |  
     ---|---|---|---|---|---|---|  
      1 | X |   |   | X |   |   |  
     ---|---|---|---|---|---|---|  
      2 |   |   |   |   |   |   |  
     ---|---|---|---|---|---|---|  
      3 |   | O | O | O | X |   |  
     ---|---|---|---|---|---|---|  
      4 |   |   |   |   |   |   |  
     ---|---|---|---|---|---|---|  
      5 | O |   | X | X |   |   |  
     ---|---|---|---|---|---|---|  
      6 |   |   |   |   |   | O |  
     ---|---|---|---|---|---|---|
     Player 2 wins the game!

## Game State Visualization

**Display - [tabuleiro.pl](Proj1/tabuleiro.pl)**

To display the board we used the predicates ``display_game(X, Player)``, ``printMatrix([], 6)`` and ``printLine([])``. ``display_game(X, Player)`` prints a row of the board, by calling ``printMatrix([], 6)``  on every iteration - ``printMatrix([], 6)`` will then make use of predicate ``printLine([])``, which recursively calls itself, printing the Head of the given list in every iteration.

Furthermore, we use "X" and "O" to represent, respectively, Player 1 and Player 2. Empty values are represented by an empty space (" "). With the use of the predicate ``symbol(Value, S)`` we were able to display X, O and " " instead of values initially declared on the board's matrix (plyr1, plyr2, empty) which would result in a less user-friendly and easy-to-read game.

- Initial State:

  ![Initial state](Proj1/img/initialstate.png)
  
  - Intermediate State:

  ![Initial state](Proj1/img/intermediatestate.png)
  
  - Final State:

  ![Initial state](Proj1/img/finalstate.png)

**Menus - [menu.pl](Proj1/menu.pl)**

When running the game, the user is prompted to a **MainMenu**, where they can select which game mode they want to play. The available modes are:

- Player vs Player
- Player vs Computer
- Computer vs Computer

  ![Main Menu](Proj1/img/mainmenu.png)

If the player decides to select a game mode which involves a Computer they are asked about the difficulty of the given Computer, which can either be Easy or Hard.

  ![Main Menu 2](Proj1/img/mainmenu2.png)

Furthermore, there is also a **Pause Menu**, which can be prompted whilst in game, by typing either 'pause', p or 'P', when asked for either a column or a row. The available options for the Pause Menu are:

	- Resume;
	- Return to Main Menu;
	- Exit game.

If the player decides to resume the game, it continues normally from when it was paused. On the other hand, if the player decides to return to the Main Menu, the game loop is interrupted and the player is prompted to the Main Menu. Finally, if the players chooses to exit the game the execution of the game is aborted.

  ![Main Menu 2](Proj1/img/pausemenu.png)

## Valid moves - [ai.pl](Proj1/ai.pl) & [input.pl](Proj1/input.pl)

To obtain a list of all possible moves for a given Player, we implemented the predicate ``valid_moves(+GameState, +Player, -ListOfMoves)``. This gives (using the findall predicate from library lists) a list that includes all possible moves (Row and Column), as well as the board state after playing that move. This is done using the auxiliary predicate ``testMove``.
Regarding user input/move verification, we implemented the predicate ``readInput``. This reads user input and verifies if it's valid, this is, if the position is part of the board and if that position is not already occupied by another piece.
Additionally, regarding computer input/move generation, we implemented the predicate ``choose_move(+GameState, +Player, +Level, -Move)``. More can be read about this predicate in the section "Computer Move".



## Move execution - [game.pl](Proj1/game.pl) & [utils.pl](Proj1/utils.pl)

The execution of every (human and machine) move is completed using the predicate ``move(+GameState, +Move, -NewGameState)``. This predicate receives a list (Move) with the format ``[Row, Col, Player]`` and applies the move to the gamestate accordingly (using ``replaceInMatrix`` and ``repulsions`` predicates).
However, since the verification/generation is different depending wether it's a human or the machine playing, the predicate move is called in the predicate ``playMove``, which also generates the move accordingly, using the predicates described in the section above (it also manipulates the value of ``Flag`` in order to deal with the 'Return to Main Menu' option in the Pause Menu).




## Game Over - [play.pl](Proj1/game.pl) & [utils.pl](Proj1/utils.pl)

At the end of each turn, the predicate ``checkVictory`` is called. ``checkVictory`` processes the Pause Menu input and calls (if necessary) the predicate ``game_over(+GameState, -Winner)``, which iterates the entire board and verifies if any victory requirement has been met. If so, the predicate will succeed and unify Winner with the victor, otherwise it will fail, continuing the gameloop.
In order to check the victory requirements the following predicates are used:
- ``eightOnBoard(+FlatBoard,1,+Value,8)``: iterates through a flat list (FlatBoard) and succeeds only if it finds 8 elements of a given Value;
- ``checkAllAux(7,7,+Board,+Value)``: iterates through the matrix (Board) and succeeds only if it finds 3 in a row in any direction.



## Board Evaluation - [utils.pl](Proj1/utils.pl) & [ai.pl](Proj1/ai.pl)

Gekitai is a fairly recent game. This being said, the game is still "unresolved", which required us to implement a system that evaluates board states for each player on our own. This system consists of the following:
- A board with 3 in a row or 8 pieces on board for a given player(victory) adds to the evaluation +100 points;
- A board with 3 in a row or 8 pieces on board for the opponent of the given player(defeat) adds to the evaluation -100 points;
- A board that the given player cannot place a piece on (the next turn is not his) and has at least 1 move for his opponent that grant him the victory adds to the evaluation -100 points;
- Each piece on board of a given player adds to the evaluation +1 point;
- Each piece on board of the opponent of a given player adds to the evaluation -2 points;
- Each 2 in a row for a given player adds to the evaluation +5 points;
- Each 2 in a row for the opponent of the given player adds to the evaluation -20 points;
The predicate that computes this evaluation is ``value(+GameState, +Player, -Value)``, using the auxiliary predicates ``piecesOnBoard``(similar to ``eightOnBoard``) and ``directionalPoints``. Since this evaluation includes (most of the time) the evaluation of one move ahead, it takes some time for the process to be complete (worst case ~25 seconds).



## Computer Move - [ai.pl](Proj1/ai.pl) & [utils.pl](Proj1/utils.pl)

As for "articial intelligence", we implemented 2 different difficulty levels: 'Easy' and 'Hard'. As mentioned in the section 'Valid Moves', we generate moves using the predicate ``choose_move(+GameState, +Player, +Level, -Move)``. Depending on the selected level, Level will either be 1 (Easy) or 2 (Hard):
- Easy (Level 1): in this mode the computer will generate random values for both the Row and Column and check wether or not that position is valid (if it's not, it generates the random values again until it finds a valid position).
- Hard (Level 2): in this mode the computer will generate every valid move and its associated board state (using ``valid_moves(+GameState, +Player, -ListOfMoves)`` to generate the moves), iterate through them and evaluate each board (using ``iterateMoveList(+ListOfMoves, [], +Player, -EvalMatrix)``, that uses ``value(+GameState, +Player, -Value)``) and select the moves with the highest evaluation (using ``selectBestMoves(-200, [], +EvalMatrix, -BestMoves)``). It then proceeds to select (randomly) one of the considered "best moves".
The generated move will also be written as output in the format "PC played move %C%R" with C being the Column ('A' to 'F') and R being the Row (1 to 6), in order to improve user readibility.


## Conclusions

Firstly, the development of this project was extremely time demanding, as Prolog is a completely different programming language, compared to the ones we're used to. However, as weeks went by, our understanding of its syntax and processing improved, which allowed us to develop every functionality required, without bugs or issues being found in the final version of the project. This being said, it's safe to affirm that this project contributed immensely to our learning process in Prolog.
However, regarding the "artificial intelligence", it feels like some adjustments could have been made in order to reduce the execution time of the move selection, as well as increase the quality of "next move evaluations", this is, looking for guaranteed victories or better positions instead of just checking if there's an upcoming defeat threat. 



## Bibliography

- [The Prolog Dictionary](http://www.cse.unsw.edu.au/~billw/dictionaries/prolog/)
- [SWI-Prolog](https://www.swi-prolog.org/)
- [SICStus Prolog Documentation](https://sicstus.sics.se/sicstus/docs/latest4/pdf/sicstus.pdf)
- Moodle slides.







