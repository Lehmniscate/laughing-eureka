require_relative 'stepping_piece.rb'

class Pawn < Piece

  def moves
    moves = []

    potential_moves = move_dirs
    first_loop = true

    until potential_moves.empty?
      move = potential_moves.shift
      next_pos = (0..1).map {|i| @pos[i] + move[i]}

      if self.in_bounds?(next_pos) && @board[next_pos].is_a?(NullPiece)
        moves << next_pos
        if first_loop && @pos == @start_pos
          first_loop = false
          potential_moves << (0..1).map { |i| move[i] * 2 }
        end
      end

    end

    diagonals.each do |move|
      next_pos = (0..1).map {|i| @pos[i] + move[i]}
      moves << next_pos if self.in_bounds?(next_pos) && @board[next_pos].enemy?(self)
    end

    moves
  end

  def diagonals
    @color == :black ? [[1,1],[1,-1]] : [[-1,1],[-1,-1]]
  end

  def move_dirs
    @color == :black ? [[1,0]] : [[-1,0]]
  end

  def initialize(board, pos)
    super
    @start_pos = pos
  end

  def to_s
    if @color == :white
      "\u2659".encode('utf-8')
    else
      "\u265F".encode('utf-8')
    end
  end

end
