# Game Class

# Checks for winner after each move
  # Checks for winning sequences (4 up, across, or diagonal going from bottom)
# Makes sure move's are valid (i.e. column isn't full)
# Keeps track of occupied spaces
# Keeps track of which player's pieces are where

require_relative 'player'

class Game
  def initialize(rows=6, columns=7)
    @player1 = create_player('Player 1', 'X')
    @player2 = create_player('Player 2', 'O')
    @active_player = @player1
    @board = Board.new(6,7)
    @rows = @board.rows
    @columns = @board.columns
    @game_over = false
    @round = 0
    @board = Array.new(@rows) {Array.new(@columns)}
  end

  attr_reader :columns, :rows

  def choose_player_type(player)
    puts "What type of player is #{player}?"
    player_type = gets.chomp.downcase
    until player_type == 'human' || player_type == 'computer'
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
      @round += 1
      player_move(@active_player)
      print_board
      check_if_won
      change_active
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
    # ISSUE WITH EACH HERE?
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

  def player_move(player)
    column = player.move
    until valid_move?(column)
      column = player.move
    end

    @board.reverse_each do |row|
      if row[column] == nil
        row[column] == player.symbol
        return
      end
    end
    puts "Player move error"
    return 
  end

  def valid_move?(move)
    if @board[0][move] != nil
      return false
    end
    return true
  end

  def game_over?
    four_diagonal? || four_horizontal? || four_vertical?
  end

  def check_if_won
    if game_over? == true
      @game_over = true
      puts "Good game. #{@active_player.name} won the game in #{round} rounds."
    end
  end

  def print_board
    @board.each do |row|
      row.each do |column|
        print column.nil? ? '[ ]' : "[#{column}]"
      end
      print "\n"
    end
  end
end