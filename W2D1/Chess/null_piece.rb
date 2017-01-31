require_relative 'piece.rb'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def enemy?(other_piece)
    false
  end

  def to_s
    " "
  end

  def dup_with(board)
    return self
  end

end
