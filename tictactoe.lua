-- Tic Tac Toe Game with Improved AI using Minimax algorithm with Alpha-Beta pruning

-- Initialize the board
local board = { {' ', ' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '} }

-- Function to print the board
local function printBoard()
    print("\n  1   2   3")
    for i = 1, 3 do
        io.write(i .. " ")
        for j = 1, 3 do
            io.write(board[i][j])
            if j < 3 then io.write(" | ") end
        end
        print()
        if i < 3 then print(" ---|---|---") end
    end
    print()
end

-- Function to check for a win
local function checkWin(player)
    for i = 1, 3 do
        -- Check rows and columns
        if (board[i][1] == player and board[i][2] == player and board[i][3] == player) or
           (board[1][i] == player and board[2][i] == player and board[3][i] == player) then
            return true
        end
    end
    -- Check diagonals
    if (board[1][1] == player and board[2][2] == player and board[3][3] == player) or
       (board[1][3] == player and board[2][2] == player and board[3][1] == player) then
        return true
    end
    return false
end

-- Function to check for a tie
local function checkTie()
    for i = 1, 3 do
        for j = 1, 3 do
            if board[i][j] == ' ' then
                return false
            end
        end
    end
    return true
end

-- Function to make a move
local function makeMove(player, row, col)
    if row < 1 or row > 3 or col < 1 or col > 3 then
        print("Invalid move. Row and column must be between 1 and 3.")
        return false
    elseif board[row][col] ~= ' ' then
        print("Invalid move. Cell already occupied.")
        return false
    else
        board[row][col] = player
        return true
    end
end

-- Function to check if a move is a winning move for a player
local function isWinningMove(player, row, col)
    local originalValue = board[row][col]
    board[row][col] = player
    local win = checkWin(player)
    board[row][col] = originalValue
    return win
end

-- Minimax function with Alpha-Beta pruning
local function minimax(player, depth, isMaximizing, alpha, beta)
    if checkWin('X') then
        return -1
    elseif checkWin('O') then
        return 1
    elseif checkTie() then
        return 0
    end

    if isMaximizing then
        local bestScore = -math.huge
        for i = 1, 3 do
            for j = 1, 3 do
                if board[i][j] == ' ' then
                    board[i][j] = 'O'
                    local score = minimax('X', depth + 1, false, alpha, beta)
                    board[i][j] = ' '
                    bestScore = math.max(bestScore, score)
                    alpha = math.max(alpha, score)
                    if beta <= alpha then
                        break
                    end
                end
            end
        end
        return bestScore
    else
        local bestScore = math.huge
        for i = 1, 3 do
            for j = 1, 3 do
                if board[i][j] == ' ' then
                    board[i][j] = 'X'
                    local score = minimax('O', depth + 1, true, alpha, beta)
                    board[i][j] = ' '
                    bestScore = math.min(bestScore, score)
                    beta = math.min(beta, score)
                    if beta <= alpha then
                        break
                    end
                end
            end
        end
        return bestScore
    end
end

-- Function to simulate AI move (Minimax algorithm with Alpha-Beta pruning)
local function aiMove()
    local bestScore = -math.huge
    local bestMove = {}

    for i = 1, 3 do
        for j = 1, 3 do
            if board[i][j] == ' ' then
                board[i][j] = 'O'
                local score = minimax('X', 0, false, -math.huge, math.huge)
                board[i][j] = ' '

                if score > bestScore then
                    bestScore = score
                    bestMove = {i, j}
                end
            end
        end
    end

    board[bestMove[1]][bestMove[2]] = 'O'
end

-- Function to handle a player's move
local function playerMove(player)
    print("Player " .. player .. ", enter your move (row and column): ")
    local row, col = io.read("*n", "*n")
    io.read() -- to consume the newline character left by io.read("*n", "*n")
    return makeMove(player, row, col)
end

-- Main game loop for playing with a friend
local function playWithFriend()
    local currentPlayer = 'X'
    while true do
        printBoard()
        if playerMove(currentPlayer) then
            if checkWin(currentPlayer) then
                printBoard()
                print("Player " .. currentPlayer .. " wins!")
                break
            elseif checkTie() then
                printBoard()
                print("It's a tie!")
                break
            else
                currentPlayer = (currentPlayer == 'X') and 'O' or 'X'
            end
        end
    end
end

-- Main game loop for playing against the computer
local function playWithAI()
    math.randomseed(os.time())
    local currentPlayer = 'X'
    while true do
        printBoard()
        if currentPlayer == 'X' then
            if playerMove(currentPlayer) then
                if checkWin(currentPlayer) then
                    printBoard()
                    print("Player " .. currentPlayer .. " wins!")
                    break
                elseif checkTie() then
                    printBoard()
                    print("It's a tie!")
                    break
                else
                    currentPlayer = 'O'
                end
            end
        else
            aiMove()
            if checkWin(currentPlayer) then
                printBoard()
                print("Player " .. currentPlayer .. " wins!")
                break
            elseif checkTie() then
                printBoard()
                print("It's a tie!")
                break
            else
                currentPlayer = 'X'
            end
        end
    end
end

-- Function to display the main menu and choose game mode
local function mainMenu()
    print("Welcome to Tic Tac Toe!")
    print("Choose a game mode:")
    print("1. Play with a friend")
    print("2. Play against the computer")
    print("Enter your choice (1 or 2): ")

    local choice = io.read("*n")
    io.read() -- to consume the newline character left by io.read("*n")

    if choice == 1 then
        playWithFriend()
    elseif choice == 2 then
        playWithAI()
    else
        print("Invalid choice. Please restart the game and choose a valid option.")
    end
end

-- Start the game
mainMenu()
