require "./checkers_piece"
require "debugger"

class CheckersBoard
  attr_accessor :board

  def initialize
    @board =  Array.new(8) { |row| Array.new(8) {nil} }
  end

  def empty?(pos)
    self[pos].nil?
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0,7)}
  end

  def valid_pos?(pos)
    in_bounds?(pos) && empty?(pos)
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

  def move!(start_pos,end_pos)
    raise "Nobody home!" if empty?(start_pos)
    piece = self[start_pos]
    if piece.possible_moves.include?(end_pos)
      piece.pos = end_pos
      self[end_pos] = piece
      self[start_pos] = nil
    else
      raise "Illegal Move!"
    end
  end

  def valid_sequence?(move_sequence)
    test_board = Marshal.load(Marshal.dump(self))
    begin
      move_sequence!(test_board, move_sequence)
    rescue
      return false
    end
    true
  end

  def move_sequence!(board,sequence)# only called for multijump moves
    start_pos = sequence.shift
    until sequence.empty?
      piece = self[start_pos]
      end_pos = sequence.shift

      if piece.jump_moves.include?(start_pos)
        board.move!(start_pos,end_pos)
      else
        raise "Broken Sequence!"
      end

      start_pos = end_pos
    end

    raise "Invalid Sequence" unless piece.jump_moves.empty?
    nil
  end


  def setup
    odds = true
    color = :b

    [0,1,2,5,6,7].each do |row|
      color = :r if row > 2
      8.times do |col|
        next if (col.even? && odds) || (col.odd? && !odds)
        self[[row,col]] = Piece.new(color,self,[row,col])
      end
      odds = odds ? false : true
    end
  nil
  end

  def render
    #system("clear")
    puts "\n\n\n\n\n\n"
    puts "\t-- 0 - 1 - 2 - 3 - 4 - 5 - 6 - 7 --"
    puts "\t-----------------------------------"
    self.board.each_with_index do |row, index|
      out = "\t#{index}|"
      row.each do |piece|
        if piece.nil?
          out += "   |"
        else
          out += piece.render + "|"
        end
      end
      puts out
      puts "\t"+("-"*(out.length))[0..-2]
    end
    puts "\n\n"
    nil
  end
end


