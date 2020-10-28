# PLOG 2020/2021 - TP1

## Group: T04_Gekitai5

| Name             | Number    | E-Mail                |
| ---------------- | --------- | --------------------- |
|   Carlos Lousada  | 201806302 | up201806302@fe.up.pt  |
|  José David Rocha   | 201806371 | up201806371@fe.up.pt  |

## Gekitai

- Game description:

        Gekitai (Repel or Push Away) is a 2-person abstract strategy game.
        Each player has eight colored markers and takes turns placing them anywhere on any open space on the board.
        When placed, a marker pushes all adjacent pieces outwards one space if there is an open space for it to move to (or off the board).
        Markers shoved off the board are returned to the player.
        If there is not an open space on the opposite side of the pushed marker, it does not push
        The first player to either line up three of their markers in a row at the end of their turn (after pushing) OR have all eight of their markers on the board (also after pushing), is declared the winner.

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
       | 0 | 1 | 2 | 3 | 4 | 5 |
    ---|---|---|---|---|---|---|
     A |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     B |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     C |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     D |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     E |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|
     F |   |   |   |   |   |   | 
    ---|---|---|---|---|---|---|


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
   
        | 1 | 2 | 3 | 4 | 5 | 6 |  
     ---|---|---|---|---|---|---|  
      A |   |   | X |   | X |   |  
     ---|---|---|---|---|---|---|  
      B |   |   |   | O |   | X |  
     ---|---|---|---|---|---|---|  
      C | O |   |   | X |   |   |  
     ---|---|---|---|---|---|---|  
      D |   |   |   |   | O | X |  
     ---|---|---|---|---|---|---|  
      E |   | X | O |   |   |   |  
     ---|---|---|---|---|---|---|  
      F | O |   |   |   | O |   |  
     ---|---|---|---|---|---|---|  


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

        | 1 | 2 | 3 | 4 | 5 | 6 |  
     ---|---|---|---|---|---|---|  
      A | X |   |   | X |   |   |  
     ---|---|---|---|---|---|---|  
      B |   |   |   |   |   |   |  
     ---|---|---|---|---|---|---|  
      C |   | O | O | O | X |   |  
     ---|---|---|---|---|---|---|  
      D |   |   |   |   |   |   |  
     ---|---|---|---|---|---|---|  
      E | O |   | X | X |   |   |  
     ---|---|---|---|---|---|---|  
      F |   |   |   |   |   | O |  
     ---|---|---|---|---|---|---|
