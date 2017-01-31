require_relative 'sliding_piece.rb'

class Queen < Piece
  include SlidingPiece

  def move_dirs
    horizontal_vertical + diagonal
  end

  def to_s
    (@color==:white ? "\u2655" : "\u265B").encode('utf-8')
  end
end
