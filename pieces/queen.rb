require_relative 'piece'

class Queen < Piece
  include Slideable

  def move_dirs
    [:diagonal, :straight]
  end
end
