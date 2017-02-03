# O(n^2)
def dumb_my_min(list)
  smallest = list.first
  list.each_with_index do |el, i|

    list.each_with_index do |el2, j|
      next if i == j
      smallest = list[i] if list[i] < list[j] && list[i] < smallest
    end
  end
  smallest
end

# O(n)
def my_min(list)
  smallest = list.first
  list.each do |el|
    smallest = el if el < smallest
  end
  smallest
end

list = [0,3,5,4,-5,10,1,90]
puts dumb_my_min(list)


def dumb_largest_contiguous_subsum(list)
  sub_arrays = []
  list.each_with_index do |el, i|
    j = i + 1
    next if i == list.length - 1
    while j < list.length
      sub_arrays << list[i..j]
      j += 1
    end
  end

  max = nil
  sub_arrays.each do |sub_array|
    sum = sub_array.reduce(:+)
    max = sum if max.nil? || sum > max
  end
  max
end

def another_largest_contiguous_subsum(list)
  max = nil
  len = list.length
  while len > 0
    list.each_cons(len) do |subarr|
      sum = subarr.reduce(:+)
      max = sum if max.nil? || sum > max
    end
  end
  max
end

def largest_contiguous_subsum(list)
  max = nil
  running_sum = 0
  list.each do |el|
    max = el if max.nil?

    if el >= 0
      running_sum += el
      max = running_sum if running_sum > max
    else
      max = running_sum if running_sum > max
      if running_sum + el > 0
        running_sum += el
      else
        running_sum = 0
      end
    end
  end
  max
end

list = [2, 3, -6, 7, -6, 7]
# puts dumb_largest_contiguous_subsum(list)
puts largest_contiguous_subsum(list)
