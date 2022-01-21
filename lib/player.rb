class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  attr_reader :symbol, :name
end

class Computer < Player
  def move(columns=7)
    move = rand(1..columns)
    return move
  end
end

class Human < Player
  def move
    puts "Please pick a column for your piece, #{@name}"
    move = gets.chomp.to_i 
    return move
  end
end
  