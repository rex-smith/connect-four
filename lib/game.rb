require_relative 'player'
require_relative 'board'

class Game
  def initialize(rows=6, columns=7)
    @player1 = nil
    @player2 = nil
    @active_player = nil
    @board = Board.new(rows, columns)
    @round = 0
  end

  attr_accessor :player1, :player2, :active_player, :board

  def create_player(name, symbol)
    player_type = choose_player_type(name)
    player_type == 'human' ? Human.new(name, symbol) : Computer.new(name, symbol)
  end

  def choose_player_type(player)
    player_type = nil
    until player_type == 'human' || player_type == 'computer'
      puts "What type of player is #{player}?"
      player_type = gets.chomp.downcase
    end
    player_type
  end

  def play_game
    @player1 = create_player('Player 1', 'X')
    @player2 = create_player('Player 2', 'O')
    puts "Round: #{@round}:"
    @board.display_board
    until game_over?
      change_active
      @round += 1
      move = player_move(@active_player)
      @board.update_board(move, @active_player)
      puts "Round: #{@round}:"
      @board.display_board
    end
    end_game
  end

  def change_active
    @active_player = @player1 == @active_player ? @player2 : @player1
  end

  def four_horizontal?
    row_limit = (@board.rows - 1).to_i
    column_limit = (@board.columns - 1).to_i
    0.upto(row_limit) do |i|
      0.upto(column_limit) do |j|
        if @board.grid[i][j] == @board.grid[i][j+1] && @board.grid[i][j] == @board.grid[i][j+2] && @board.grid[i][j] == @board.grid[i][j+3]
          return true unless @board.grid[i][j].nil?
        end
      end
    end
    false
  end

  def four_vertical?
    row_limit = (@board.rows - 4).to_i
    column_limit = (@board.columns - 1).to_i
    0.upto(row_limit) do |i|
      0.upto(column_limit) do |j|
        if @board.grid[i][j] == @board.grid[i+1][j] && @board.grid[i][j] == @board.grid[i+2][j] && @board.grid[i][j] == @board.grid[i+3][j]
          return true unless @board.grid[i][j].nil?
        end
      end
    end
    false
  end

  def four_diagonal?
    row_limit = (@board.rows - 4).to_i
    column_limit = (@board.columns - 1).to_i
    0.upto(row_limit) do |i|
      0.upto(column_limit) do |j|
        if @board.grid[i][j] == @board.grid[i+1][j+1] && @board.grid[i][j] == @board.grid[i+2][j+2] && @board.grid[i][j] == @board.grid[i+3][j+3]
          return true unless @board.grid[i][j].nil?
        end
      end
    end

    0.upto(row_limit) do |i|
      0.upto(column_limit) do |j|
        if @board.grid[i][j] == @board.grid[i-1][j+1] && @board.grid[i][j] == @board.grid[i-2][j+2] && @board.grid[i][j] == @board.grid[i-3][j+3]
          return true unless @board.grid[i][j].nil?
        end
      end
    end

    false
  end

  def player_move(player)
    column = player.move
    until @board.valid_move?(column)
      puts "You chose a full column, please enter a new column:" if @active_player.instance_of? Human 
      column = player.move
    end
    return column
  end

  def game_over?
    four_horizontal? || four_vertical? || four_diagonal?
  end

  def end_game
    puts "Good game. #{@active_player.name} won the game in #{@round} rounds."
  end

end