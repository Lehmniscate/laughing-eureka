require_relative 'tree_node'

class KnightPathFinder

  DELTAS = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [-2, 1],
    [2, -1],
    [-2, -1]
  ]

  def initialize(start_pos = [0, 0])
    @start_node = PolyTreeNode.new(start_pos)
    @visited_poses = [start_pos]
    build_move_tree(@start_node)
  end

  def build_move_tree(node)
    queue = [node]

    until queue.empty?
      cur_node = queue.shift
      queue += new_move_nodes(cur_node)
    end

  end

  def find_path(target_pos)
    @target_node = @start_node.bfs(target_pos)
    path = backtrack(@target_node)

    p path
  end

  def backtrack(node)
    cur_pos = node.value
    return [cur_pos] if node == @start_node

    backtrack(node.parent) + [cur_pos]
  end

  def new_move_nodes(node)
    new_poses = KnightPathFinder.valid_moves(node.value).reject { |p| @visited_poses.include?(p) }
    new_nodes = new_poses.map { |pos| PolyTreeNode.new(pos) }
    new_nodes.each { |child_node| child_node.parent = node }
    @visited_poses.concat(new_poses)

    new_nodes
  end

  def self.valid_moves(pos)
    valid_moves = []

    DELTAS.each do |del|
      new_pos = [pos.first + del.first, pos.last + del.last]
      valid_moves << new_pos if  KnightPathFinder.in_bounds?(new_pos)
    end

    valid_moves
  end


  def self.in_bounds?(pos)
    [pos.first, pos.last].all? { |pos| pos >= 0 && pos <= 8}
  end

end

test = KnightPathFinder.new
test.find_path([3,3])
