class Piece

  attr_reader :color

  def initialize(board, pos)
    @board = board
    @pos = pos
    @start_pos = pos
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

  def move_into_check?(end_pos)
    trial_board = @board.dup
    trial_board.move_piece!(@pos, end_pos)
    trial_board.in_check?(@color)
  end

  def dup_with(new_board)
    new_piece = self.class.new(new_board, @start_pos.dup)
    new_piece.position = @pos.dup
    new_piece
  end

  def add_position(pos1, pos2)
    (0..1).map {|i| pos1[i] + pos2[i]}
  end


end
