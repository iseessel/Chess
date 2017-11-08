require_relative 'piece'

class King < Piece
  include Steppable

  def initialize(symbol)
    super(symbol)
    @already_moved = false
  end

  def move_diffs(castling = true)
    moves = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1],
  ]
    if castling
      moves.concat(castling_diffs)
    else
      moves
    end
  end

  def castling_diffs
    diffs = []
    if able_to_left_castle
      diffs << [0, -2]
    else able_to_right_castle
      diffs << [0, 2]
    end

    diffs
  end

  def castle(direction)
    startingY, startingX = @position[0], @position[1]
    if direction == :left
      end_king_pos = [startingY, startingX - 2]
      start_castle_position = [startingY, startingX - 4]
      end_castle_position = [startingY, startingX - 1]
      @board.move_piece!(start_castle_position, end_castle_position)
      @board.move_piece!(@position, end_king_pos)
    else
      end_king_pos = [startingY, startingX + 2]
      start_castle_position = [startingY, startingX + 3]
      end_castle_position = [startingY, startingX + 1]
      @board.move_piece!(start_castle_position, end_castle_position)
      @board.move_piece!(@position, end_king_pos)
    end
  end

  #NB: These methods do not check if the king is going through pieces.
    #This will be taken care of through the valid_moves method.

  def able_to_left_castle
    left_rook = @board[[@position[0], @position[1] - 4]]
    !@board.in_check?(@color) && !@already_moved &&
      !in_line_of_attack?([0, 2]) && !left_rook.already_moved
  end

  def able_to_right_castle
    right_rook = @board[[@position[0], @position[1] + 3]]
    !@board.in_check?(@color) && !@already_moved &&
      !in_line_of_attack?([0, 2]) && !right_rook.already_moved
  end

  def in_line_of_attack?(diffs)
    opponents_color = @color == :white ? :black : :white
    pieces = @board.find_opponents_pieces(opponents_color)
    pieces.any? do |piece|
      piece.valid_moves(false).any? { |(y, x)| y == @position[0] &&
        !x.between?(@position[1], @position[1] + diffs[1])}
    end
  end

end
