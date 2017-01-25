require_relative 'board.rb'

class Game

  def initialize(filename = nil)
    @board = filename ? Board.from_file(filename) : Board.new
  end

  def play
    until @board.solved?
      @board.render
      pos = get_pos
      value = get_value
      @board.update_position(pos, value)
    end
    @board.render
    puts "Congratulations! You won."
  end

  def get_pos
    puts "Choose a position (row,col)"
    gets.chomp.split(",").map { |el| el.to_i }
  end

  def get_value
    puts "Choose a number (1 thru 9)"
    gets.chomp.to_i
  end

end
