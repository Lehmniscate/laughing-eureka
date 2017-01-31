require_relative 'sliding_piece.rb'

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    diagonal
  end

  def to_s
    if @color == :white
      "\u2657".encode('utf-8')
    else
      "\u265D".encode('utf-8')
    end
  end

end
