module SteppingPiece
  def moves
    directions = self.move_dirs
    moves = []

    directions.each do |direction|
      next_pos = add_position(@pos, direction)
      moves << next_pos if valid_move?(next_pos)
    end

    moves
  end
end
