require_relative 'sliding_piece.rb'

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal_vertical
  end

  def to_s
    (@color==:white ? "\u2656" : "\u265C").encode('utf-8')
  end

end
