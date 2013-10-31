require "./checkers_board"
class CheckersGame
  attr_accessor :board

  def initialize
    @board = CheckersBoard.new
  end

  def play
    board.setup
    board.render
  end

end

if $PROGRAM_NAME == __FILE__
  CheckersGame.new.play
end