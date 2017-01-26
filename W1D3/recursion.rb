#---------------------------------------
# Warmup Exercises
#---------------------------------------
def range(start_num, end_num)
  return [] if end_num <= start_num + 1

  arr = [start_num + 1]
  arr.concat(range(start_num + 1, end_num))
end

def sum_array_recursive(arr)
  return 0 if arr.length == 0

  arr.pop + sum_array_recursive(arr)
end

def sum_array_iterative(arr)
  sum = 0
  arr.each { |el| sum += el }
  sum
end

#---------------------------------------
# Child's Money
#---------------------------------------
def return_number(a)
  ((a / 2)**2) * (65 - (a / 2))
end

def child_age(parent_age)
  parent_age / 2
end

def years_to_retirement(age)
  65 - age
end

def bank_account_funds(age)
  age * age
end

def retirement_fund(age)
  bank_account_funds(age) * years_to_retirement(age)
end

def child_retirement_fund(parent_age)
  retirement_fund(child_age(parent_age))
end

#---------------------------------------
# Exponentiation
#---------------------------------------
def exponentiation_one(base, power)
  return 1 if power == 0
  base * exponentiation_one(base, power - 1)
end

def exponentiation_two(base, power)
  return 1 if power == 0

  new_power = square(exponentiation_two(base, half(power)))
  if power.even?
    new_power
  else
    base * new_power
  end
end

def half(power)
  power / 2
end

def square(num)
  num * num
end

#---------------------------------------
# Deep dup
#---------------------------------------
class Array

  def deep_dup
    self.map { |el| el.is_a?(Array) ? el.deep_dup : el }
  end

end

#---------------------------------------
# Fibonacci
#---------------------------------------
def fib_recursive(n)
  return nil if n < 0
  return Array.new(n, 1) if n <= 2

  fib_arr = []
  fib_arr.concat(fib_recursive(n - 1))
  fib_arr << fib_arr[n-2] + fib_arr[n-3]
  fib_arr
end

def fib_iterative(n)
  return nil if n < 0
  return Array.new(n, 1) if n <= 2

  fib_arr = [1, 1]
  until fib_arr.length == n
    fib_arr << fib_arr[-1] + fib_arr[-2]
  end

  fib_arr
end

#---------------------------------------
# Subsets
#---------------------------------------
def subsets(arr)
  return [[]] if arr.length == 0

  small_subsets = subsets(arr[0...-1])

  small_subsets.concat(small_subsets.map {|set| set += [arr.last]})
end

#---------------------------------------
# Permutations
#---------------------------------------
def permutations(array)
  return [array] if array.length == 1

  result = []
  array.each do |el|
    sub_perm = permutations(array.select{ |num| num != el })
    result.concat(sub_perm.map{ |sub_arr| sub_arr.unshift(el) } )
  end
  result
end

#---------------------------------------
# Binary Search
#---------------------------------------
def bsearch(array, target)
  return nil if array.length == 0 #WIP

  case array.middle_val <=> target
  when 1
    return bsearch(array.left_side, target)
  when 0
    return array.middle_idx
  when -1
    search_result = bsearch(array.right_side_exclude, target)
    return search_result ? search_result + array.middle_idx + 1 : nil
  end

end

class Array
  def middle_idx
    self.length / 2
  end

  def middle_val
    self[self.middle_idx]
  end

  def left_side
    self.take(self.middle_idx)
  end

  def right_side_exclude
    self.drop(self.middle_idx + 1)
  end

  def right_side
    self.drop(self.middle_idx)
  end
end

#---------------------------------------
# Merge Sort
#---------------------------------------
def merge_sort(array)
  return array if array.length <= 1

  merge(merge_sort(array.left_side), merge_sort(array.right_side))
end

def merge(array_one, array_two)
  result = []
  while array_one.first && array_two.first
    case array_one.first <=> array_two.first
    when 1
      result << array_two.shift
    when 0
      result << array_one.shift
    when -1
      result << array_one.shift
    end
  end
  if array_one.first
    result.concat(array_one)
  elsif array_two.first
    result.concat(array_two)
  end
  result
end

#---------------------------------------
# Make Change
#---------------------------------------
def greedy_make_change(num, coins_arr)
  return [] if num == 0
  ordered_coins_arr = coins_arr.sort.reverse #ordered with big coins first
  coin = ordered_coins_arr.first

  num_coins = num / coin
  remainder = num % coin
  change_arr = Array.new(num_coins){coin}

  change_arr.concat(greedy_make_change(remainder, ordered_coins_arr.drop(1)))

  change_arr
end

def make_better_change(num, coins_arr)
  return [] if num <= 0
  ordered_coins_arr = coins_arr.sort.reverse

  best_array = nil
  ordered_coins_arr.each_with_index do |coin, idx|
    next if coin > num
    test_arr = [coin] + make_better_change(num - coin, coins_arr.drop(idx))
    if best_array.nil? or test_arr.length < best_array.length
      best_array = test_arr
    end
  end
  best_array
end
