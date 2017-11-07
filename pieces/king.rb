require_relative 'piece'

class King < Piece
  include Steppable

  def move_diffs
    moves = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ]
  end
end
