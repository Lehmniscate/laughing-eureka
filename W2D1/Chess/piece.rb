class Piece

  def initialize(board, pos)
    @board = board
    @pos = pos
    @color = pos.last < 4 ? :black : :white
  end

  def enemy?(other_piece)
    other_piece.color != color
  end

  def moves

  end

  def to_s
    "O"
  end

  def valid_move?(pos)
    pos.first.between?(0, 7) && pos.last.between?(0, 7) &&
      (@board[pos].is_a?(NullPiece) || @board[pos].enemy?(self))
  end

  protected

  attr_reader :color

end
