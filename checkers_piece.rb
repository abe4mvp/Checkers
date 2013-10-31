class Piece #red on bottom, black moves first
  attr_accessor  :board, :pos, :king
  attr_reader  :color

  UPDELTAS = [[-1,1],[-1,-1]]
  DOWNDELTAS = [[1,1],[1,-1]]

  def initialize(color, board, pos, king = false)
    @color, @board, @pos, @king = color,board, pos, king
  end

  def possible_moves
    jump_moves.empty? ? slide_moves : jump_moves
  end

  def jump_moves
    jumps = []
    my_deltas.each do |delta|
      slide = pos.add_delta(delta)
      next unless board.valid_pos?(slide)
      jump = slide.add_delta(delta)
      jumps << jump if board.valid_pos?(jump) #also make sure jumping enemy
    end

    jumps
  end

  def slide_moves
    my_deltas.map do |delta|
      pos.add_delta(delta)
    end.keep_if { |pos| board.valid_pos?(pos) }
  end

  def enemy?(pos)#move to board?
    raise "Empty spot" if board.empty?([pos])

    board[[pos]].color != color
  end



  def my_deltas
    return (UPDELTAS + DOWNDELTA) if king
    color == :r ? UPDELTAS : DOWNDELTAS
  end

  def render
    player = color == :r ? "red" : "bla"
    king ? player.upcase : player
  end

end



class Array
  def add_delta!(delta)
    self.each_with_index { |item,index| self[index] += delta[index]}
  end

  def add_delta(delta)
    self.dup.add_delta!(delta)
  end

end
