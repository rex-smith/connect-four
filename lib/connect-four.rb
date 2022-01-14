# Game Class

# Checks for winner after each move
  # Checks for winning sequences (4 up, across, or diagonal going from bottom)
# Makes sure move's are valid (i.e. column isn't full)
# Keeps track of occupied spaces
# Keeps track of which player's pieces are where

class Game
  def initialize(rows=6, columns=7)
    @player1 = create_player('Player 1', 'X')
    @player2 = create_player('Player 2', 'O')
    @active_player = @player1
    @rows = rows
    @columns = columns
    @game_over = false
    @round = 0
    @board = Array.new(@rows) {Array.new(@columns)}
  end

  attr_reader :columns

  def choose_player_type(player)
    puts "What type of player is #{player}?"
    player_type = gets.chomp.downcase
    until gets.chomp.downcase == 'human' || gets.chomp.downcase == 'computer'
     choose_player_type
    end
    player_type
  end

  def create_player(name, symbol)
    player_type = choose_player_type(name)
    player_type == 'human' ? Human.new(name, symbol) : Computer.new(name, symbol)
  end

  def play_game
    until @game_over == true
      print_board
      round += 1
      @active_player.choose_column
      print_board
      check_if_won
      change_active
      @active_player.choose_column
      check_if_won
    end
  end

  def change_active
    @active_player = @player1 == @active_player ? @player2 : @player1
  end

  def four_horizontal?
    for i in rows
      for j in columns
        if @board[i][j] == @board[i][j+1] && @board[i][j] == [i][j+2] && @board[i][j] == @board[i][j+3]
          return true unless @board[i][j].nil?
        end
      end
    end
    false
  end

  def four_vertical?
    for i in rows
      for j in columns
        if @board[i][j] == @board[i+1][j] && @board[i][j] == [i+2][j] && @board[i][j] == @board[i+3][j]
          return true unless @board[i][j].nil?
        end
      end
    end
    false
  end

  def four_diagonal?
    for i in rows
      for j in columns
        if @board[i][j] == @board[i+1][j+1] && @board[i][j] == [i+2][j+2] && @board[i][j] == @board[i+3][j+3]
          return true unless @board[i][j].nil?
        end
      end
    end
    for i in rows
      for j in columns
        if @board[i][j] == @board[i-1][j-1] && @board[i][j] == [i-2][j-2] && @board[i][j] == @board[i-3][j-3]
          return true unless @board[i][j].nil?
        end
      end
    end
    false
  end

  def winner?
    four_diagonal? || four_horizontal? || four_vertical
  end

  def check_if_won
    if winner? == true
      @game_over = true
      puts "Good game. #{@active_player.name} won the game in #{round} rounds."
    end
  end

  def print_board
    board.each do |row|
      row.each do |column|
        p column.nil? ? '[ ]' : "[#{column}]"
      end
      print '/n'
    end
  end
end


# Player Class
# Computer Player or Human (Need to figure out how to make two types of the class)
  # Player Chooses column to play a piece in
  # Board is updated with piece and checked for win

class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def choose_column
    # Where either player chooses a column (basically outputs which column or makes them redo)
  end
end

class Computer < Player
  def move
    # NEED TO SOMEHOW MAKE THIS ALWAYS THE NUMBER OF GAME COLUMNS
    move = rand(1..7)
  end
end

class Human < Player
  def move
    puts "Please pick a column for your piece, #{@name}"
    move = gets.chomp.to_i
    return move
  end
end