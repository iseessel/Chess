class HumanPlayer
  attr_reader :color

  def initialize(name, color, display, board)
    @name = name
    @color = color
    @display = display
    @board = board
  end

  def get_input
    start_pos, end_pos = nil, nil
    until start_pos && end_pos
      @display.render
      if start_pos
        puts "#{@color}, choose an end move."
        end_pos = @display.cursor.get_input
      else
        puts "#{@color}, choose a starting move"
        pos = @display.cursor.get_input
        if pos
          if @board[pos].color == @color
            start_pos = pos
            @display.selected_pos = start_pos
          end
        end
      end
    end

    return [start_pos, end_pos]
  end


end
