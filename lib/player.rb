# Player Class
# Computer Player or Human (Need to figure out how to make two types of the class)
  # Player Chooses column to play a piece in
  # Board is updated with piece and checked for win

  class Player
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end
  
    attr_reader :symbol, :name
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
  