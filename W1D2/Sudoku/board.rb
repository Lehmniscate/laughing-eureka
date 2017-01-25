require_relative 'tile.rb'

class Board

  def initialize(board = nil)
    @board = board || Array.new(9) { Array.new(9) { Tile.new(0) } }
  end

  def self.from_file(filename)
    numbers = File.readlines(filename)
    numbers.map! do |line|
      line.chomp.split("").map do |num|
        Tile.new(num.to_i)
      end
    end
    Board.new(numbers)
  end

  def update_position(pos, value)
    row, col = pos
    @board[row][col].value = value
  end

  def render
    @board.each do |row|
      row_output = []
      row.each do |tile|
         row_output << tile.to_s
      end
      puts row_output.join
    end
  end

  def solved?
    (0...9).each do |i|
      return false unless check_row(i)
      return false unless check_col(i)
    end
    (0...3).each do |i|
      (0...3).each do |j|
        return false unless check_square([i, j])
      end
    end
    true
  end

  def check_square(nonent)
    start_row = nonent.first * 3
    start_col = nonent.last * 3
    numbers = (1..9).to_a
    @board[start_row...start_row+3].each do |row|
      row[start_col...start_col+3].each do |tile|
        if(numbers.include?(tile.value))
          numbers.delete(tile.value)
        else
          return false
        end
      end
    end
    true
  end

  def check_row(row)
  numbers = (1..9).to_a
    @board[row].each do |tile|
      if(numbers.include?(tile.value))
        numbers.delete(tile.value)
      else
        return false
      end
    end
    true
  end

  def check_col(col)
  numbers = (1..9).to_a
    @board.each do |row|
      if(numbers.include?(row[col].value))
        numbers.delete(row[col].value)
      else
        return false
      end
    end
    true
  end

end
