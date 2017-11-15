require 'colorize'
require 'byebug'
require_relative 'board'
require_relative 'cursor'

class Display
  attr_accessor :selected_pos, :current_color
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @selected_pos = nil
    @current_color = nil
  end

  def render
    system('clear')
    selected_piece = @selected_pos ? @board[@selected_pos]
      : @board[@cursor.cursor_pos]
    moves = selected_piece.valid_moves
    (0..7).each do |row|
      (0..7).each do |column|
        pos = [row, column]
        piece = @board[pos]
        colors(pos, moves, selected_piece, piece)
      end
      puts ""
    end
  end

  private
  
  def colors(pos, moves, selected_piece, piece)
    if pos == @selected_piece || pos == @cursor.cursor_pos
      print " #{piece.to_s} ".colorize(background: :red)
    elsif moves.include?(pos) && selected_piece.color == @current_color
      print " #{piece.to_s} ".colorize(background: :blue ).blink
    elsif (pos[0] + pos[1]).odd?
      print " #{piece.to_s} ".colorize(background: :white)
    else
      print " #{piece.to_s} "
    end
  end

end
