# README

## Overview 
Terminal Chess is a terminal version of the popular game chess, coded in Ruby.

## Features 
- User friendly color-highlighting of possible moves.
- Move pieces based on the established rules of the game.
- Capture pieces when appropriate. 
- Check and checkmate capabilities.
- Implementation of special moves, such as castling, en passant, and pawn promotion.

## Object Orientatin Highlights

### Slideable and Steppable Moduels for Dry and Extensible Code. 
Each slideable/steppable piece responds with its own move directions or steps respectively, and through this the steppable modules dynamically generates a piece's valid move. 
This implementation allows for a standardized, easy to read approach to the complicaated rules of chess.

(code-screenshots/slideable.png)
(code-screenshots/queen.png)

### Simple and Clean Implementation of check and checkmate.
My object orientated approach allows for us to easily check the board for check and checkmate. 
For in-check, I look if any of the opponents moves(other than castling) include the kings position. 
For checkmate, I check if I am currently in check and have no valid moves(with the stipulation that a valid move cannot leave me/put me in check.)
In seperating concerns, I provide easy to read code

(code-screenshots/in-check.png)
