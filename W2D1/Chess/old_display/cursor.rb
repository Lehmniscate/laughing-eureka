require 'curses'

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    Curses.noecho
    Curses.init_screen
    Curses.stdscr.keypad(true)
  end

  def get_input
      key = KEYMAP[read_char]
      handle_key(key)
  end

  private

  def read_char
    case Curses.getch
    when Curses::Key::PPAGE
      Curses.setpos(0,0)
      Curses.addstr("Page Up")
    when Curses::Key::NPAGE
      Curses.setpos(0,0)
      Curses.addstr("Page Dn")
    end
  end

  def handle_key(key)
    case key
    when :return, :space
      return @cursor_pos
    when :right, :left, :up, :down
      update_pos(MOVES[key])
      return nil
    when :ctrl_c
      Process.exit
    else
      nil
    end
  end

  def update_pos(diff)
    new_pos = (0..1).map {|i| @cursor_pos[i] + diff[i] }
    @cursor_pos = new_pos if @board.in_bounds?(new_pos)
  end
end
