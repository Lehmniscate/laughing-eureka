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
  end

  def [](i)
    j = i < 0 ? @count + i : i
    return nil unless j.between?(0, @count - 1)

    @store[j]
  end

  def []=(i, val)
    j = i < 0 ? @count + i : i
    return nil unless j.between?(0, @count - 1)

    @store[j] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    (0...capacity).each do |i|
      return true if @store[i] == val
    end
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity

    @count.downto(1) do |i|
      @store[i] = @store[i - 1]
    end

    @count += 1
    @store[0] = val
  end

  def pop
    return nil if @count == 0

    @count -= 1
    val = @store[@count]
    @store[@count] = nil

    val
  end

  def shift
    return nil if @count == 0

    val = @store[0]

    (0...@count - 1).each do |i|
      @store[i] = @store[i+1]
    end
    @store[@count - 1] = nil

    @count -= 1
    val
  end

  def first
    return nil if @count == 0
    @store[0]
  end

  def last
    return nil if @count == 0
    @store[@count - 1]
  end

  def each
    (0...@count).each do |i|
      yield(@store[i])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)

    (0...@count).each do |i|
      return false unless self[i] == other[i]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(capacity * 2)

    (0...@count).each do |i|
      new_array[i] = self[i]
    end

    @store = new_array
  end
end
