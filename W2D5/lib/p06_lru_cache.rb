require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache

  attr_reader :count

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    link = @map.get(key)

    if link.nil?
      val = calc!(key)
      @store.append(key, val)
      @map.set(key, @store.last)
    else
      update_link!(link)
    end

    eject! if count > @max

    @store.last.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
