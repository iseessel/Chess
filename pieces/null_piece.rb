require_relative 'piece'

class NullPiece < Piece
  include Singleton

  def initialize
    @symbol = "\u0020"
  end

  def valid_moves
    []
  end
end
