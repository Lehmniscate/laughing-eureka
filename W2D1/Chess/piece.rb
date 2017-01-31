class Piece

  attr_reader :color

  def initialize(board, pos)
    @board = board
    @pos = pos
    @color = pos.first < 4 ? :black : :white
  end

  def enemy?(other_piece)
    other_piece.color != color
  end

  def moves
    []
  end

  def to_s
    "O"
  end

  def valid_move?(pos)
    self.in_bounds?(pos) &&
      (@board[pos].is_a?(NullPiece) || @board[pos].enemy?(self))
  end

  def in_bounds?(pos)
    pos.first.between?(0, 7) && pos.last.between?(0, 7)
  end

  def position=(pos)
    @pos = pos
  end

end
