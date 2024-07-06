# Tic Tac Toe Game in Lua

This is a simple Tic Tac Toe game implemented in Lua, featuring two game modes:
- Play with a friend
- Play against the computer (Minimax algorithm with Alpha-Beta pruning)


## Game Features

- Two players: 'X' and 'O'
- Game board displayed in the console
- Ability to choose game mode: play with a friend or against the computer
- AI opponent uses Minimax algorithm with Alpha-Beta pruning for intelligent moves

## How to Play

1. Clone the Repository

2. **Run the Game:**
   Ensure you have Lua installed on your system.

   ```bash
   lua tictactoe.lua
   ```

3. **Game Modes:**
   - **Play with a friend:** Two players take turns entering their moves.
   - **Play against the computer:** You play as 'X' against an AI opponent ('O').

4. **Gameplay Instructions:**
   - When it's your turn, enter the row and column (1-3) where you want to place your symbol ('X' or 'O').
   - The game will display the updated board after each move.
   - The game ends when a player wins by getting three of their symbols in a row, column, or diagonal, or when the board is full (tie).

## Code Structure

- `tictactoe.lua`: Contains the main game logic, including board initialization, player moves, AI moves (using Minimax algorithm), win/tie checks, and game loop for different modes.
- `README.md`: This file, providing instructions and information about the game.

## 

