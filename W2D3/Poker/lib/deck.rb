require_relative 'card'

class Deck

  attr_reader :cards

  def initialize
    @cards = new_deck.shuffle
  end

  def draw
    raise "No More Cards" if @cards.empty?
    @cards.pop
  end

  def reset
    @cards = new_deck.shuffle
  end

  private

  def new_deck
    result = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        result << Card.new(suit, value)
      end
    end
    result
  end
end
