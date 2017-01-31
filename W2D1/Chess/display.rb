require 'colorize'
require_relative 'board.rb'
require_relative 'cursor.rb'

class Display
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def input
    spaced = nil
    until spaced
      render
      spaced = @cursor.get_input
    end
    @cursor.cursor_pos
  end

  def render
    system 'clear'
    (0..7).each do |i|
      row = ''
      (0..7).each do |j|
        piece = @board[[i,j]].to_s
        if @cursor.cursor_pos == [i,j]
          piece = piece.colorize(color: :red, background: :light_black)
        end
        row << " #{piece} "
      end
      puts row
    end
  end

end
