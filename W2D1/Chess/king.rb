require_relative 'stepping_piece.rb'

class King < Piece
  include SteppingPiece

  def to_s
    (@color==:white ? "\u2654" : "\u265A").encode('utf-8')
  end

  def move_dirs
    [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
  end

end
