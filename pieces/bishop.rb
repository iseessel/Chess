require_relative 'piece'

class Bishop < Piece
  include Slideable

  def move_dirs
    [:diagonal]
  end
end
