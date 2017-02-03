require_relative 'minmaxstackqueue'

#O(n^2)
def naive_windowed_max_range(list, range)
  current_max_range = nil
  (0..list.length - range).each do |i|
    this_range = list[i...range+i].max - list[i...range+i].min
    if current_max_range.nil? || this_range > current_max_range
      current_max_range = this_range
    end
  end
  current_max_range
end

def optimized(list, range)

  #queue = new minmaxstackqueue of size range with the first range els of list
  #move left to right, dequeueing and enqueuing one at a times
  #each iteration query max - min which my queue alreay knows now
  #return biggest max - min
  queue = MinMaxStackQueue.new
  range.times do
    queue.enqueue(list.shift)
  end
  current_max_range = queue.max - queue.min
  until list.empty?
    queue.dequeue
    queue.enqueue(list.shift)
    if (queue.max - queue.min > current_max_range)
      current_max_range = queue.max - queue.min
    end
  end
  current_max_range
end

puts optimized([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
puts optimized([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
puts optimized([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
puts optimized([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
