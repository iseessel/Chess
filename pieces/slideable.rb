require 'byebug'

module Slideable
  DIAGONAL = [[1,1],[1,-1],[-1,-1],[-1,1]]
  STRAIGHT = [[1,0], [-1,0], [0,1], [0,-1]]

  def moves(castling = true)
    direction = self.move_dirs

    moves = []

    moves += find_moves(DIAGONAL) if direction.include?(:diagonal)
    moves += find_moves(STRAIGHT) if direction.include?(:straight )

    moves
  end

  def find_moves(deltas)
    moves = []
    deltas.each do |(dx, dy)|
      # current_pos = self.position
      x, y = self.position
      next_move = [x + dx, y + dy]
      until !self.board.valid_move?(self.position, next_move)
        #
        moves << next_move
        break if opponent?(next_move)
        # current_pos = next_move
        x, y = next_move
        next_move = [x + dx, y + dy]
        #
      end
    end

    moves
  end

  def opponent?(next_move)
    self.board[next_move].color && self.board[next_move].color != self.color
  end
end
