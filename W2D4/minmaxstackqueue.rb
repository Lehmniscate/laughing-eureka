require 'byebug'
class MinMaxStackQueue
  # Queue
  # enqueue: adds an element to the back of the queue
  # dequeue: removes an element from the front of the queue and returns it
  def initialize
    @stack1 = MinMaxStack.new
    @stack2 = MinMaxStack.new
  end

  def enqueue(item)
    @stack1.push(item)
  end

  def dequeue
    if @stack2.empty?
      until @stack1.empty?
        temp = @stack1.pop
        @stack2.push(temp)
      end
    end
    @stack2.pop
  end

  def min
    return @stack1.min if @stack2.empty?
    return @stack2.min if @stack1.empty?
    @stack1.min < @stack2.min ? @stack1.min : @stack2.min
  end

  def max
    return @stack1.max if @stack2.empty?
    return @stack2.max if @stack1.empty?
    @stack1.max > @stack2.max ? @stack1.max : @stack2.max
  end
end

class MyQueue
  # Implement enqueue, dequeue, peek, size, and empty? methods on your Queue.
  def initialize
    @store = []
  end

  def enqueue(item)
    @store.push(item)
  end

  def dequeue
    @store.shift(item)
  end

  def peek
    @store.first
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  # Implement pop, push, peek, size, and empty? methods on your Stack.
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(item)
    @store.push(item)
  end

  def peek
    @store.last
  end

  def empty?
    @store.empty?
  end
end

class MinMaxStack

  def initialize
    @store = MyStack.new
    @min = MyStack.new
    @max = MyStack.new
  end

  def pop
    item = @store.pop
    if @min.peek == item
      @min.pop
    end
    if @max.peek == item
      @max.pop
    end
    item
  end

  def push(item)

    @store.push(item)
    if @max.empty? || item >= @max.peek
      @max.push(item)
    end
    if @min.empty? || item <= @min.peek
      @min.push(item)
    end
  end

  def min
    @min.peek
  end

  def max
    @max.peek
  end

  def empty?
    @store.empty?
  end
end

class StackQueue

  def initialize
    @queued = MyStack.new
    @dequeued = MyStack.new
    @size = 0
  end

  def enqueue(item)
    @size.times {@dequeued.push(@queued.pop)}
    @queued.push(item)
    @size.times {@queued.push(@dequeued.pop)}
    @size += 1
  end

  def dequeue
    @size -= 1
    item = @queued.pop
    @dequeued.push(item)
    return item
  end

  def peek
    @queued.peek
  end

  def size
    @size
  end

  def empty?
    @size == 0
  end
end
