require_relative 'sliding_piece.rb'

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    diagonal
  end

  def to_s
    (@color==:white ? "\u2657" : "\u265D").encode('utf-8')
  end

end
