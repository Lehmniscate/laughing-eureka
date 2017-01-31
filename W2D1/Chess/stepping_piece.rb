module SteppingPiece
  def moves
    directions = self.move_dirs
    moves = []

    directions.each do |direction|
      next_pos = (0..1).map {|i| @pos[i] + direction[i]}
      moves << next_pos if valid_move?(next_pos)
    end

    moves
  end
end
