require_relative 'cell'
class Board

  def initialize(board)
    @board = board
  end

  def self.random_board(num_bombs = 18, size = [9,9])
    rows, cols = size
    seed = "*" * num_bombs + " " * (rows * cols)
    seed = seed.split("").shuffle

    board = Array.new(rows) {Array.new(cols)}
    board = board.map do |row|
      row.map do |cell|
        cell_seed = seed.shift
        Cell.new(cell_seed == "*")
      end
    end
    board = Board.set_adjacents(board)
    Board.new(board)
  end

  def self.set_adjacents(board)
    board.each_with_index do |row, i|
      row.each_with_index do |el, j|
        next if el.bomb?
        adjacents = 0
        adjacent_positions(i,j,board).each do |adj|
          adjacents += 1 if board[adj.first][adj.last].bomb?
        end
        el.num_adjacent = adjacents
      end
    end
  end

  def won?
    won = true
    @board.each do |row|
      row.each do |cell|
        if !cell.revealed? && !cell.bomb?
          won = false
        end
      end
    end
    won

  end

  def render
    puts "  #{(0...9).to_a.map(&:to_s).join(" ")}"
    @board.each_with_index do |row, index|
      row_output = [index.to_s]
      row.each do |cell|
        row_output << cell.to_s
      end

      puts row_output.join(" ")
    end
    true
  end

  def adjacent_cells(row, col)
    Board.adjacent_positions(row, col, @board)
  end

  def self.adjacent_positions(row, col, board)
    left = (row>0) ? row-1 : row
    right = (row<board.size-1) ? row+1 : row
    top = (col>0) ? col-1 : col
    bottom = (col<board.first.size-1) ? col+1 : col

    adjacents = []
    (left..right).each do |i|
      (top..bottom).each do |j|
        adjacents << [i,j] unless [i,j] == [row,col]
      end
    end
    adjacents
  end

  def flag(row, col)
    @board[row][col].toggle_flag
  end

  def reveal(row, col)
    return true if @board[row][col].revealed?
    return false if @board[row][col].bomb?
    @board[row][col].reveal

    if @board[row][col].num_adjacent == 0
      adjacent_cells(row, col).each do |pos|
        self.reveal(pos[0], pos[1])
      end
    end
    true
  end

  def run
    until won?
      system "clear"
      render
      puts "you can flag (f) or reveal (r) at any pos (row, col)"
      input = gets.chomp.split(",")
      pos = input.drop(1).map(&:to_i)
      if input.first == "f"
        flag(pos[0], pos[1])
      elsif input.first == "r"
        break unless reveal(pos[0], pos[1])
      end
    end
  end

end

board = Board.random_board
