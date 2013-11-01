require "./checkers_board"
class CheckersGame
  attr_accessor :board

  def initialize
    @board = CheckersBoard.new
    player_turn = :b
  end

# REV: No check for game over or UI?
# REV: You would probably implement a rescue here to catch raised InvalidMoveErrors in this play loop to give the user another opportunity to put in a valid move
  def play
    #until game over
      board.setup
      board.render
      #board.move(color)
      player_turn = player_turn = :b ? :r : :b
    #end
  end

end

if $PROGRAM_NAME != __FILE__
  $g = CheckersGame.new
  $g.play
end