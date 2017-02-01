require 'colorize'
require 'curses'

class Display
  include Curses

  def initialize(board)
    init_screen
    noecho
    curs_set 0
    @board = board
    @cursor_pos = [0,0]
    start_color
    init_pair(COLOR_RED, COLOR_CYAN, COLOR_YELLOW)
    init_pair(COLOR_WHITE, COLOR_BLACK, COLOR_WHITE)
    init_pair(COLOR_BLACK, COLOR_RED, COLOR_BLACK)
  end

  def input(name)
    refresh
    spaced = nil
    until spaced
      render
      place_string(9,1,"#{name}, please make a move")
      spaced = get_input
    end
    @cursor_pos.dup
  end

  def get_input
    case getch
    when 27
      getch
      case getch
      when "B"
        @cursor_pos[0] = (@cursor_pos.first + 1) % 8
      when "A"
        @cursor_pos[0] = (@cursor_pos.first - 1) % 8
      when "D"
        @cursor_pos[1] = (@cursor_pos.last - 1) % 8
      when "C"
        @cursor_pos[1] = (@cursor_pos.last + 1) % 8
      end
    when ' '
      return @cursor_pos
    end
    nil
  end

  def render
    (0..7).each do |i|
      (0..7).each do |j|
        piece = @board[[i,j]].to_s
        if @cursor_pos == [i,j]
          place_string(i, j*3," #{piece.to_s} ", COLOR_RED)#.colorize(color: :red, background: :white))
        else
          if (i + j) % 2 == 0
            place_string(i, j*3," #{piece.to_s} ", COLOR_WHITE)#.colorize(background: :light_white))
          else
            place_string(i, j*3," #{piece.to_s} ", COLOR_BLACK)#.colorize(background: :light_black))
          end
        end
      end
    end
  end

  def place_string(y, x, string, color = COLOR_WHITE)
    setpos(y, x)

    attron(color_pair(color)|A_NORMAL) {
      addstr(string)
    }
  end

end

def onsig(signal)
  Curses.close_screen
  exit signal
end
