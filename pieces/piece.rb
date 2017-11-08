require_relative 'slideable'
require_relative 'steppable'
require 'singleton'

class Piece
  attr_accessor :position, :board, :color, :symbol, :already_moved
  def initialize(symbol)
    @symbol = symbol
    @already_moved = false
  end

  def to_s
    @symbol.encode('utf-8')
  end

  def valid_moves(castling = true)
    moves = self.moves(castling)
    valid_moves = []

    moves.each do |move|
      board = self.board.deep_dup
      board.move_piece!(@position, move)
      valid_moves << move unless board.in_check?(@color)
    end

    valid_moves
  end

end
