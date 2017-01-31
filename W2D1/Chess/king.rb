require_relative 'stepping_piece.rb'

class King < Piece
  include SteppingPiece

  def to_s
    if @color == :white
      "\u2654".encode('utf-8')
    else
      "\u265A".encode('utf-8')
    end
  end

  def move_dirs
    [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end

end
