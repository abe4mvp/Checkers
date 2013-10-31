require "./checkers_board"
class CheckersGame
  attr_accessor :board

  def initialize
    @board = CheckersBoard.new
    player_turn = :b
  end

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