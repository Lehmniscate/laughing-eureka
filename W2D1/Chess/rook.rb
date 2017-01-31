require_relative 'sliding_piece.rb'

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal_vertical
  end

  def to_s
    "R"
  end

end
