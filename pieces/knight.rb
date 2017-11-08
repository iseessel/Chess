require_relative 'piece'

class Knight < Piece
  include Steppable

  def move_diffs(castling)
    moves = [
      [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1]
    ]
  end
end
