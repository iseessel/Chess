require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player_one = HumanPlayer.new("player_one", :white, @display, @board)
    @player_two = HumanPlayer.new("player_two", :black, @display, @board)
    @current_player = @player_one
  end

  def play
    system('clear')
    puts "Zoom in for optimal gameplay."
    puts "Use your arrow buttons to move your cursor."
    puts "Press enter to select your starting/ending move."
    sleep(4)
    until @board.check_mate?(@current_player.color)
      begin
      @display.current_color = @current_player.color
      start_pos, end_pos = @current_player.get_input
      @board.move_piece(start_pos, end_pos, @current_player.color)
      @display.selected_pos = nil
      switch_players
      rescue
        print "Invalid Move"
        @display.selected_pos = nil
        sleep(1)
        retry
      end
    end
  end

  private

  def switch_players
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

end
