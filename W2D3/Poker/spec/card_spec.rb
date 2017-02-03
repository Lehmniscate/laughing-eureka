require 'card'

describe "Card" do
  context "#initialize" do
    subject(:card) { Card.new(:clubs, 10) }

    it "sets suit" do
      expect(card.suit).to eq(:clubs)
    end

    it "sets value" do
      expect(card.value).to eq(10)
    end

    it "raises an ArgumentError when given an invalid card" do
      expect{ Card.new(:clubs, 17) }.to raise_error(ArgumentError)
      expect{ Card.new(:kitties, 12) }.to raise_error(ArgumentError)
    end
  end
end
