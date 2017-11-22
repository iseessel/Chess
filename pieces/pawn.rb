require_relative 'piece'
require 'byebug'

class Pawn < Piece

  def moves
    forward_moves + attacking_moves
  end

  def forward_moves
    deltas = self.forward_move_diffs

    moves = []
    deltas.each do |(dx, dy)|
      x, y = self.position
      move = [x + dx, y + dy]

      if valid_pawn_step?(move)
        moves << move
      else
        break
      end
    end

    moves
  end

  def attacking_moves
    deltas = self.attacking_move_diffs

    moves = []
    deltas.each do |(dx, dy)|
      x, y = self.position
      move = [x + dx, y + dy]

      if valid_pawn_attack?(move)
        moves << move
      end
    end

    #makes sure that if a pawn moves forward one space, that he cannot move
    #forward two.
    moves
  end

  def valid_pawn_step?(move)
    @board.valid_move?(@position, move) && @board.null_piece?(move) # don't check if color is nil check method empty
  end

  def valid_pawn_attack?(move)
      @board.valid_move?(@position, move) &&
      !@board.null_piece?(move)  &&  # check if empty not check color of null piece
      @board[move].color != @color #check if opponent. Helper mycolor
  end


end

class WhitePawn < Pawn

  FIRSTMOVE_DIFFS = [[-1, 0], [-2, 0]]
  ATTACK_DIFFS = [[-1, 1], [-1, -1]]

  def forward_move_diffs
    return FIRSTMOVE_DIFFS if self.position.first == 6 #pawn row

    FIRSTMOVE_DIFFS.take(1)
  end

  def attacking_move_diffs
    ATTACK_DIFFS
  end

end

class BlackPawn < Pawn
  FIRSTMOVE_DIFFS = [[1, 0], [2, 0]]
  ATTACK_DIFFS = [[1, 1], [1, -1]]

  def forward_move_diffs
    return FIRSTMOVE_DIFFS if self.position.first == 1

    FIRSTMOVE_DIFFS.take(1)
  end

  def attacking_move_diffs
    ATTACK_DIFFS
  end


end
