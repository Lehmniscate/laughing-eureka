class Card

  SUITS = [:clubs, :hearts, :diamonds, :spades]
  VALUES = [2,3,4,5,6,7,8,9,10,11,12,13,14]

  attr_reader :suit, :value

  def initialize(suit, value)
    raise ArgumentError unless SUITS.include?(suit) &&
                                VALUES.include?(value)
    @suit, @value = suit, value
  end
end
