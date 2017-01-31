require_relative 'stepping_piece.rb'

class Pawn < Piece

  def moves
    moves = []

    potential_moves = move_dirs
    first_loop = true

    until potential_moves.empty?
      move = potential_moves.shift
      next_pos = add_position(@pos, move)

      if self.in_bounds?(next_pos) && @board[next_pos].is_a?(NullPiece)
        moves << next_pos
        if first_loop && @pos == @start_pos
          first_loop = false
          potential_moves << add_position(move, move)
        end
      end

    end

    diagonals.each do |move|
      next_pos = add_position(@pos, move)
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

  def to_s
    (@color==:white ? "\u2659" : "\u265F").encode('utf-8')
  end

end
