require_relative "chess_exceptions.rb"
require_relative "null_piece.rb"
require_relative "pawn.rb"
require_relative "bishop.rb"
require_relative "knight.rb"
require_relative "rook.rb"
require_relative "king.rb"
require_relative "queen.rb"

class Board

  BLANK_ROW = [:Rook, :Knight, :Bishop, :Queen, :King, :Bishop, :Knight, :Rook]
  # BLANK_ROW = [:Piece] * 8

  def initialize
    @board = setup_board
  end

  def [](pos)
    @board[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @board[pos[0]][pos[1]] = value
  end

  def setup_board
    soon_board = Array.new(8) { [] }

    rows = ([BLANK_ROW]) + ([[:Pawn] * 8]) +
            ([[:NullPiece]*8]*4) +
            ([[:Pawn] * 8]) + ([BLANK_ROW])

    rows.each_with_index do |row, row_i|
      if row_i.between?(2, 5)
        row.each { |sym| soon_board[row_i] << eval("#{sym}.instance") }
      else
        row.each_with_index do |sym, j|
          soon_board[row_i] << eval("#{sym}.new(self, [row_i, j])")
        end
      end
    end

    soon_board
  end

  def in_bounds?(pos)
    pos.first.between?(0, 7) && pos.last.between?(0, 7)
  end

  def move_piece(start_pos, end_pos)
    raise NoPieceAtStartPosition if self[start_pos].is_a?(NullPiece)
    raise EndPositionNotValid unless self[start_pos].valid_move?(end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end

end
