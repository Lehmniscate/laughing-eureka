require_relative 'stepping_piece.rb'

class Knight < Piece
  include SteppingPiece

  def to_s
    (@color==:white ? "\u2658" : "\u265E").encode('utf-8')
  end

  def move_dirs
    [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  end

end
