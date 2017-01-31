require_relative 'sliding_piece.rb'

class Queen < Piece
  include SlidingPiece

  def move_dirs
    horizontal_vertical + diagonal
  end

  def to_s
    if @color == :white
      "\u2655".encode('utf-8')
    else
      "\u265B".encode('utf-8')
    end
  end
end
