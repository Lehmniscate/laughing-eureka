require 'benchmark'

arr = (0..200000000).to_a.shuffle
arr

# O(n^2)
def bad_two_sum?(arr, target_sum)

  (0...arr.length - 1).each do |i|
    (i + 1...arr.length).each do |j|
      return true if arr[i] + arr[j] == target_sum
    end
  end
  false
end

# O(nlogn) (quicksort is technically O(n^2))
def okay_two_sum?(arr, target_sum)
  sorted = arr.sort

  low, high = 0, arr.length - 1
  until low >= high
    case sorted[low] + sorted[high] <=> target_sum
    when -1 then low += 1
    when 0 then return true
    when 1 then high -= 1
    end
  end
  false
end

# O(n)
def two_sum?(arr, target_sum)
  numbers = Hash.new {|h,k| h[k] = false}
  arr.each do |num|
    return true if numbers[target_sum - num]
    numbers[num] = true
  end
  false
end

# O(n^3)
def four_sum?(arr, target_sum)
  doubles = Hash.new {|h,k| h[k] = false}
  seen = Hash.new {|h,k| h[k] = false}
  (0...arr.length - 1).each do |i|
    (i + 1...arr.length).each do |j|
      if doubles[target_sum - (arr[i] + arr[j])]
        return true unless seen[i] || seen[j]
      end
      doubles[arr[i]+arr[j]] = true
      seen[i], seen[j] = true, true
    end
  end
  false
end



include Benchmark
n = 1

Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
  tf = x.report("bad:")   { for i in 1..n; a = "hi"; end }
tt = x.report("okay:") { for i in 1..n ; okay_two_sum?(arr, 500000); end }
tu = x.report("optimal:")  { for i in 1..n ; two_sum?(arr, 500000); end }
[tf+tt+tu, (tf+tt+tu)/3]
end
