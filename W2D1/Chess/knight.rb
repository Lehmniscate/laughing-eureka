require_relative 'stepping_piece.rb'

class Knight < Piece
  include SteppingPiece

  def to_s
    if @color == :white
      "\u2658".encode('utf-8')
    else
      "\u265E".encode('utf-8')
    end
  end

  def move_dirs
    [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  end

end
