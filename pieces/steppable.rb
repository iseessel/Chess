module Steppable

  def moves(castling = true)

    deltas = self.move_diffs
    moves = []

    deltas.each do |(dx, dy)|
      x, y = self.position
      move = [x + dx, y + dy]
      moves << move if self.board.valid_move?(self.position, move)
    end

    moves
  end
end
