require "./checkers_piece"

class CheckersBoard
  attr_accessor :board

  def initialize
    @board =  Array.new(8) { |row| Array.new(8) {nil} }
  end

  def setup
    odds = true
    color = :b
    [0,1,2,5,6,7].each_with_index do |row,index|
      color = :r if row > 2
      8.times do |col|
        next if col.even? && !odds
        board[row,col] = Piece.new(:b,self,[row,col])
      end
      odds = odds ? false : true
    end
  nil
  end

  def setup
    odds = true
    color = :b
    [0,1,2,5,6,7].each_with_index do |row, index|
      color = :r if index > 2
       do |col|
        next if col.even? && !odds
        board[row,col] = Piece.new(:b,self,[row,col])
      end
      odds = odds ? false : true
    end
  nil
  end

  def empty?(pos)
    unless in_bounds?(pos)
      raise "out of bounds"
      return false
    end
    self[pos].nil?
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0,7)}
  end

  def [](pos)
    raise "invalid pos" unless in_bounds?(pos)

    row, col = pos
    board[row][col]
  end

  def []=(pos,value)
    row, col = pos
    board[row][col] = value
  end

  def must_jump?(color)
    ####
  end

  def render
    system("clear")
    puts "\n\n\n\n\n\n"
    puts "\t-- 0 - 1 - 2 - 3 - 4 - 5 - 6 - 7 --"
    puts "\t-----------------------------------"
    board.each_with_index do |row, index|
      out = "\t#{index}|"
      row.each do |item|
        if item.nil?
          out += "   |"
        else
          out += item.render "|"
        end
      end
      puts out
      puts "\t"+("-"*(out.length))[0..-2]
    end
    puts "\n\n"
    nil
  end
end

