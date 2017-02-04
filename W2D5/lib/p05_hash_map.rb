require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @list = LinkedList.new
    @count = 0
  end

  def include?(key)
    self[key] ? true : false
  end

  def set(key, val)
    unless @store[bucket(key)].update(key, val)
      @list.append(key, val)
      @store[bucket(key)].append(key, val)
      @count += 1
    end

    resize! if @count > num_buckets
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @count -= 1 if @store[bucket(key)].remove(key)
    @list.remove(key)
  end

  def each
    @list.each do |link|
      yield(link.key, @store[bucket(link.key)].get(link.key))
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each do |link|
        self[link.key] = link.val
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
