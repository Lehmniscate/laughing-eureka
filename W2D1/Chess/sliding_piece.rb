module SlidingPiece

  def moves
    directions = self.move_dirs
    moves = []

    directions.each do |direction|
      prev_pos = @pos
      next_pos = (0..1).map {|i| prev_pos[i] + direction[i]}

      enemy_found = false
      while valid_move?(next_pos) && !enemy_found
        enemy_found = true if @board[next_pos].enemy?(self)
        moves << next_pos
        next_pos = (0..1).map {|i| next_pos[i] + direction[i]}
      end
    end

    moves
  end

  def horizontal_vertical
    [[0,1],[1,0],[-1,0],[0,-1]]
  end

  def diagonal
    [[1,1],[-1,1],[-1,-1],[1,-1]]
  end

end
