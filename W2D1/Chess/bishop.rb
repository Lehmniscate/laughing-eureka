require_relative 'sliding_piece.rb'

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    diagonal
  end

  def to_s
    "B"
  end

end
