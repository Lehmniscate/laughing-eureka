class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
  end

  def [](i)
    j = i < 0 ? @count + i : i
    return nil unless j.between?(0, @count - 1)

    @store[(@start_idx + j) % capacity]
  end

  def []=(i, val)
    j = i < 0 ? @count + i : i
    return nil unless j.between?(0, @count - 1)

    @store[(@start_idx + j) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    (0...@count).each do |i|
      return true if @store[(@start_idx + i) % capacity] == val
    end
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[(@start_idx + @count) % capacity] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    @count += 1
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx] = val
  end

  def pop
    return nil if @count == 0

    @count -= 1
    val = @store[(@start_idx + @count) % capacity]

    val
  end

  def shift
    return nil if @count == 0

    val = @store[@start_idx]

    @start_idx = (@start_idx + 1) % capacity

    @count -= 1

    val
  end

  def first
    return nil if @count == 0
    @store[@start_idx]
  end

  def last
    return nil if @count == 0
    @store[(@start_idx + @count - 1) % capacity]
  end

  def each
    (0...@count).each do |i|
      yield(@store[(@start_idx + i) % capacity])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    (0...@count).each do |i|
      return false unless self[(@start_idx + i) % capacity] == other[i]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(capacity * 2)

    (0...@count).each do |i|
      new_array[i] = self[(@start_idx + i) % capacity]
    end

    @start_idx = 0
    @store = new_array
  end
end
