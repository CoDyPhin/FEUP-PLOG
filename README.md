# PLOG 2020/2021 - TP1

## Group: T04_Gekitai5

| Name             | Number    | E-Mail                |
| ---------------- | --------- | --------------------- |
|   Carlos Lousada  | 201806302 | up201806302@fe.up.pt  |
|  José David Rocha   | 201806371 | up201806371@fe.up.pt  |

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


## Internal representation of the game state

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
    Row:
    |: 


- Intermediate Situation:

```
    midBoard([  
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
     Row:
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
     3 in a row found!

## Game State Visualization

​	To display the board we used the predicates printBoard(X), printMatrix([], 6) and printLine([]). printBoard(X) prints a row of the board, by calling printMatrix([], 6)  on every iteration - printMatrix([], 6) will then make use of predicate printLine([]), which recursively calls itself, printing the Head of the given list in every iteration.

​	Furthermore, we used "X" and "O" to represent, respectively, Player 1 and Player 2. Empty values are represented by an empty space (" "). With the use of the predicate symbol(Value, S) we were able to display X, O and " " instead of values initially declared on the board's matrix (plyr1, plyr2, empty) which would result in a less user-friendly and easy-to-read game.

- Inital State:

  ![Initial state](img/initialstate.png)
  
  - Intermediate State:

  ![Initial state](img/intermediatestate.png)
  
  - Final State:

  ![Initial state](img/finalstate.png)
