require_relative 'pieces/entry'

class InvalidEndPosition < StandardError
end

class MissingPieceError < StandardError
end

class Board
  attr_accessor :grid

  COORDS = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h"=> 7
  }

  def initialize
    @grid = nil
    setup
  end

  def setup
    @grid = populate
    set_up_pieces
    @grid
  end

  # private
  def self.pos_to_coord(string)
    string.reverse.chars.map do |ch|
      ch.between?("a","z") ? COORDS[ch] : 8 - (ch.to_i)
    end
  end

  def populate
    first_row = [[Rook.new("\u265C"), Knight.new("\u265E"), Bishop.new("\u265D"),
    Queen.new("\u265B"), King.new("\u265A"), Bishop.new("\u265D"),
    Knight.new("\u265E"), Rook.new("\u265C")]]

    second_row = [Array.new(8) { BlackPawn.new("\u265F") }]

    third_through_sixth_row = Array.new(4) do
      Array.new(8) { NullPiece.instance }
    end

    seventh_row = [Array.new(8) { WhitePawn.new("\u2659") }]

    last_row = [[Rook.new("\u2656"), Knight.new("\u2658"), Bishop.new("\u2657"),
    Queen.new("\u2655"), King.new("\u2654"), Bishop.new("\u2657"),
    Knight.new("\u2658"), Rook.new("\u2656")]]

    @grid = first_row + second_row + third_through_sixth_row +
    seventh_row + last_row
  end

  def set_up_pieces
    (0..7).each do |i|
      (0..7).each do |j|
        pos = [i, j]
        self[pos].position = pos
        self[pos].board = self
        if i.between?(0,1)
          self[pos].color = :black
        elsif i.between?(6,7)
          self[pos].color = :white
        end
      end
    end
  end

  def user_move(start, finish)
    start , finish = Board.pos_to_coord(start), Board.pos_to_coord(finish)
    self[finish] = self[start]
    self[start] = NullPiece.instance
    self[finish].position = finish
  end

  def move_piece(start, finish, color)
    piece = self[start]
    valid_moves = piece.valid_moves
    raise InvalidMoveError unless valid_moves.include?(finish) &&
      piece.color == color && start != finish

    if piece.instance_of? King
      if finish[1] - start[1] == 2
        piece.castle(:right)
        return
      elsif finish[1] - start[1] == -2
        piece.castle(:left)
        return
      end
    end

    move_piece!(start, finish)

  end

  def move_piece!(start, finish)
    self[finish] = self[start]
    self[start] = NullPiece.instance
    self[finish].position = finish
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos[0], pos[1]
    @grid[x][y] = value
  end

  def in_bounds?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def own_piece?(start_pos, end_pos)
    self[start_pos].color == self[end_pos].color
  end

  def valid_move?(start_pos, end_pos)
    in_bounds?(end_pos) && !own_piece?(start_pos, end_pos)
  end

  def in_check?(color)
    king_pos = find_king_pos(color)
    opponent_pieces = find_opponents_pieces(color)

    #NB: We must tell the moves method that we do not want to check the opponent's
    #castling moves, otherwise we will infinitely iterate.

    opponent_pieces.any? do |piece|
        piece.moves(false).include?(king_pos)
    end
  end

  def check_mate?(color)
    in_check?(color) && find_own_pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  def find_own_pieces(color)
    @grid.flatten.select { |piece| piece.color && piece.color == color }
  end

  def find_king_pos(color)
    @grid.flatten.find { |piece| piece.is_a?(King) && piece.color == color }.position
  end

  def find_opponents_pieces(color)
    @grid.flatten.select { |piece| piece.color && piece.color != color }
  end

  def deep_dup
    new_board = Board.new
    grid = []
    0.upto(7) do |row|
      sub_arr = []
      0.upto(7) do |col|
        if self[[row, col]].is_a? NullPiece
          sub_arr << NullPiece.instance
        else
          piece = self[[row, col]]
          new_piece = piece.class.new(piece.symbol)
          new_piece.color = piece.color
          new_piece.position = [row, col]
          new_piece.board = new_board
          sub_arr << new_piece
        end
      end
      grid << sub_arr
    end

    new_board.grid = grid
    new_board
  end

  def length
    @grid.length
  end

end
