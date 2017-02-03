class Array
  def my_uniq
    self.dup.uniq
    # i = 0
    # result = []
    # while i < length
    #   result << self[i] unless result.include? self[i]
    #   i += 1
    # end
    # result
  end

  def two_sum
    result = []
    (0...length-1).each do |i|
      (i+1...length).each do |j|
        result << [i, j] if self[i] + self[j] == 0
      end
    end
    result
  end
end

def my_transpose(array)
  raise ArgumentError unless is_matrix?(array)

  result = Array.new(array.first.length) { [] }
  (0...array.length).each do |i|
    (0...array.first.length).each do |j|
      result[j] << array[i][j]
    end
  end

  result
end

def is_matrix?(array)
  array.each do |row|
    return false unless row.count == array.first.count
  end
  true
end

def stock_picker(array)
  raise ArgumentError unless array.is_a?(Array) && array.length > 1

  days = nil
  (0...array.length-1).each do |i|
    (i+1...array.length).each do |j|
      if days.nil? || array[j] - array[i] > array[days[1]] - array[days[0]]
        days = [i, j]
      end
    end
  end
  days
end

class TowersOfHanoi

  attr_accessor :towers

  def initialize
    @towers = Array.new(3) { [] }
    @towers[0] = [3, 2, 1]
  end

  def valid_move?(start_tower, end_tower)
    return false if @towers[start_tower].empty?
    return true if @towers[end_tower].empty?
    @towers[end_tower].last > @towers[start_tower].last
  end

  def move(start_tower, end_tower)
    raise "invalid move" unless valid_move?(start_tower, end_tower)

    @towers[end_tower] << @towers[start_tower].pop
  end

  def won?
    @towers[1].count == 3 || @towers[2].count == 3
  end

  def play
    until won?
      puts "Enter the tower numbers from and to on the form: 3,2"
      start_tower, end_tower = get_input
      move(start_tower, end_tower)
    end
    puts "Game Over!"
  end

  def get_input
    gets.chomp.split(",")
  end
end
