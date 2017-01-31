require 'colorize'
require_relative 'cursor.rb'

class Display
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def input(name)
    spaced = nil
    until spaced
      render
      puts "#{name}, please make a move"
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
          row << " #{piece} ".colorize(color: :red, background: :white)
        else
          if (i + j) % 2 == 0
            row << " #{piece} ".colorize(background: :light_white)
          else
            row << " #{piece} ".colorize(background: :light_black)
          end
        end
      end
      puts row
    end
  end

end
