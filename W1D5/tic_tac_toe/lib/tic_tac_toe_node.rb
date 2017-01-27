require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos =
      board, next_mover_mark, prev_move_pos

  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_nodes = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |node, j|
        #figure out mover marks later
        next unless @board.empty?([i,j])
        board = @board.dup
        board[[i,j]] = @next_mover_mark
        next_move = (@next_mover_mark == :x) ? :o : :x
        empty_nodes << TicTacToeNode.new(board, next_move, [i,j]) #if @board.empty?([i,j])
      end
    end
    empty_nodes
  end
end
