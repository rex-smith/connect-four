class Board
  def initialize(rows=6, columns=7)
    @rows = rows
    @columns = columns
    @grid = Array.new(@rows) {Array.new(@columns)}
  end

  attr_accessor :grid, :rows, :columns

  def valid_move?(column)
    if @grid[@rows-1][column-1] != nil
      return false
    elsif column > @columns
      return false
    end
    return true
  end

  def update_board(column, player)
    @grid.each do |row|
      if row[column-1] == nil
        row[column-1] = player.symbol
        return
      end
    end
  end

  def display_board
    @grid.reverse_each do |row|
      row.each do |column|
        print column.nil? ? '[ ]' : "[#{column}]"
      end
      print "\n"
    end
    print "\n"
  end

end