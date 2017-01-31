require_relative 'sliding_piece.rb'

class Rook < Piece
  include SlidingPiece

  def move_dirs
    horizontal_vertical
  end

  def to_s
    if @color == :white
      "\u2656".encode('utf-8')
    else
      "\u265C".encode('utf-8')
    end
  end

end
