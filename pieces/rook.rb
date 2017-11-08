require_relative 'piece'

class Rook < Piece
  include Slideable
  
  attr_reader :already_moved

  def initialize(symbol)
    super(symbol)
    @already_moved = false
  end

  def move_dirs
    [:straight]
  end

end
