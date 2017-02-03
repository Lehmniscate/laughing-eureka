require 'benchmark'
# O(n!)
def first_anagram?(first_string, second_string)

  all_anagrams = first_string.chars.permutation(first_string.length).map(&:join)

  all_anagrams.include?(second_string)

end

# O(n)
def second_anagram?(first_string, second_string)
  word_one = first_string.chars.reject {|ch| second_string.include? ch }
  word_two = second_string.chars.reject {|ch| first_string.include? ch}
  word_one.empty? && word_two.empty?
end

# O(nlogn), n2 in the very worst cases due to ruby's quick sort
def third_anagram?(first_string, second_string)
  first_string.chars.sort == second_string.chars.sort
end

# O(n)
def fourth_anagram?(first_string, second_string)
  first_hash = Hash.new {0}
  first_string.chars.each do |char|
    first_hash[char] += 1
  end
  second_hash = Hash.new {0}
  second_string.chars.each do |char|
    second_hash[char] += 1
  end

  first_hash == second_hash
end

#O(n)
def bonus_fourth_anagram?(first, second)
  hash = Hash.new {0}
  first.chars.each {|ch| hash[ch] += 1}
  second.chars.each {|ch| hash[ch] -= 1}

  hash.values.all? {|el| el == 0}
end


include Benchmark
n = 5_000
# puts benchmark.measure {fourth_anagram?("gizmo", "sally")}
#
# puts fourth_anagram?("gizmo", "sally")
# puts fourth_anagram?("elvis", "lives")
#
# puts "bonus"
# puts bonus_fourth_anagram?("gizmo", "sally")
# puts bonus_fourth_anagram?("elvis", "lives")

Benchmark.benchmark(CAPTION, 7, FORMAT, ">total:", ">avg:") do |x|
  tf = x.report("first:")   { for i in 1..n; first_anagram?("thequi", "foxjum"); end }
tt = x.report("second:") { for i in 1..n ; second_anagram?("thequi", "foxjum"); end }
tu = x.report("third:")  { for i in 1..n ; third_anagram?("thequi", "foxjum"); end }
[tf+tt+tu, (tf+tt+tu)/3]
end
