class Board
  def initialize(rows=6, columns=7)
    @rows = rows
    @columns = columns
  end

  attr_reader :rows, :columns
end