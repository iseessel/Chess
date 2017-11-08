module Steppable

  def moves(castling = true) # Will take in an array of deltas & add deltas to current pos checking if valid

    deltas = self.move_diffs(castling)
    moves = []

    deltas.each do |(dx, dy)|
      x, y = self.position
      move = [x + dx, y + dy]
      moves << move if self.board.valid_move?(self.position, move)
    end

    moves
  end
end
