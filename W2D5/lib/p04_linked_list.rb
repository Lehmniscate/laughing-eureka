class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new("head")
    @tail = Link.new("tail")
    head.next = @tail
    tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    link = link_get(key)
    return nil if link.nil?
    link.val
  end

  def link_get(key)
    each do |link|
      return link if link.key == key
    end
    nil
  end

  def include?(key)
    each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    link = Link.new(key, val)

    @tail.prev.next = link
    link.prev = @tail.prev

    link.next = @tail
    @tail.prev = link
  end

  def update(key, val)
    link = link_get(key)
    return false if link.nil?

    link.val = val
  end

  def remove(key)
    old_link = link_get(key)
    return false if old_link.nil?

    prev_link = old_link.prev
    next_link = old_link.next

    prev_link.next = next_link
    next_link.prev = prev_link

    old_link.prev = nil
    old_link.next = nil
    old_link
  end

  def each(&prc)
    link = @head.next
    until link == @tail
      prc.call(link)
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
