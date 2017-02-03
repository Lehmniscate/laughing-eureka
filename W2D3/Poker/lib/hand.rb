class Hand

  attr_reader :cards

  def initialize
    @cards = []
  end

  def discard_card(card)
    raise "Empty Hand" if @cards.empty?
    raise "Missing Card" unless @cards.include? card
    @cards.delete(card)
  end

  def add_card(card)
    raise "Full Hand" if @cards.count == 5
    @cards << card
  end

  def hand_value
    raise "Incomplete Hand" if @cards.count < 5
    return straight_flush if straight_flush
    return four_of_a_kind if four_of_a_kind
    return full_house if full_house
    return flush if flush
    return straight if straight
    return three_of_a_kind if three_of_a_kind
    return two_pair if two_pair
    return one_pair if one_pair
    high_card
  end

  private

  def high_card
    values = @cards.map(&:value).sort.reverse
    values = values.map {|val| val < 10 ? "0#{val}" : "#{val}"}
    ('1' + values.join).to_i
  end

  def one_pair
    value_count = Hash.new(0)
    @cards.each { |card| value_count[card.value] += 1 }
    return false unless value_count.has_value? 2

    values = [value_count.key(2)]

    values += value_count.keys.select do |key|
      value_count[key] == 1
    end.sort.reverse


    values = values.map {|val| val < 10 ? "0#{val}" : "#{val}"}
    ('2' + values[0]*2 + values.drop(1).join).to_i

  end

  def two_pair
    value_count = Hash.new(0)
    @cards.each { |card| value_count[card.value] += 1 }
    return false unless value_count.keys.count == 3

    values = value_count.keys.select do |key|
      value_count[key] == 2
    end.sort.reverse

    values << value_count.key(1)

    values = values.map {|val| val < 10 ? "0#{val}" : "#{val}"}
    ('3' + values[0]*2 + values[1]*2 + values[2]).to_i
  end

  def three_of_a_kind
    value_count = Hash.new(0)
    @cards.each { |card| value_count[card.value] += 1 }
    return false unless value_count.has_value? 3

    three = value_count.key(3)
    three = three < 10 ? "0#{three}" : three.to_s

    values = value_count.keys.select {|key| value_count[key] == 1}
    values = values.sort.map {|val| val < 10 ? "0#{val}" : "#{val}"}

    ('4' + three * 3 + values.reverse.join).to_i
  end

  def straight
    values = @cards.map {|card| card.value}.sort
    4.times {|i| return false if values[i] + 1 != values[i+1]}
    values = values.map {|val| val < 10 ? "0#{val}" : "#{val}"}
    ('5' + values.reverse.join).to_i
  end

  def flush
    return false if @cards.any? {|card| card.suit != @cards[0].suit}
    values = @cards.map {|card| card.value}.sort
    values = values.map {|val| val < 10 ? "0#{val}" : "#{val}"}
    ('6' + values.reverse.join).to_i
  end

  def full_house
    value_count = Hash.new(0)
    @cards.each { |card| value_count[card.value] += 1 }
    return false unless value_count.has_value? 3
    return false unless value_count.has_value? 2
    two = value_count.key(2)
    two = two < 10 ? "0#{two}" : two.to_s
    three = value_count.key(3)
    three = three < 10 ? "0#{three}" : three.to_s
    ('7' + three * 3 + two * 2).to_i
  end

  def four_of_a_kind
    value_count = Hash.new(0)
    @cards.each { |card| value_count[card.value] += 1 }
    return false unless value_count.has_value? 4
    extra = value_count.key(1)
    extra = extra < 10 ? "0#{extra}" : extra.to_s
    four = value_count.key(4)
    four = four < 10 ? "0#{four}" : four.to_s
    ('8' + four * 4 + extra).to_i
  end

  def straight_flush
    return false if @cards.any? {|card| card.suit != @cards[0].suit}
    values = @cards.map {|card| card.value}.sort
    4.times {|i| return false if values[i] + 1 != values[i+1]}
    values = values.map {|val| val < 10 ? "0#{val}" : "#{val}"}
    ('9' + values.reverse.join).to_i
  end

end
