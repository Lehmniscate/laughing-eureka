class PolyTreeNode

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue.concat(node.children)
    end
    nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def value
    @value
  end

  def children
    @children
  end

  def remove_child(child)
    raise Exception unless @children.include?(child)
    child.parent = nil
  end

  def add_child(child)
    child.parent = self
  end

  def parent
    @parent
  end

  def parent=(par_node)
    old_parent = @parent
    @parent = par_node
    old_parent.children.delete(self) unless old_parent.nil?
    return nil if @parent.nil?
    @parent.children << self unless @parent.children.include?(self)
  end

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
end
