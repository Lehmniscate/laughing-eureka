require_relative 'stepping_piece.rb'

class Pawn < Piece

  def moves
    moves = []

    directions = (@pos == @start_pos ? first_move_dirs : move_dirs)
    diagonals.each do |move|
      next_pos = (0..1).map {|i| @pos[i] + move[i]}
      moves << next_pos if @board[next_pos].enemy?(self)
    end
    directions.each do |direction|
      next_pos = (0..1).map {|i| @pos[i] + direction[i]}
      moves << next_pos if valid_move?(next_pos)
    end
    moves
  end

  def diagonals
    @color == :black ? [[1,1],[1,-1]] : [[-1,1],[-1,-1]]
  end

  def move_dirs
    @color == :black ? [[1,0]] : [[-1,0]]
  end

  def first_move_dirs
    @color == :black ? [[1,0],[2,0]] : [[-1,0],[-2,0]]
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
