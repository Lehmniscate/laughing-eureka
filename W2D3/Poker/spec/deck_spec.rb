require 'deck'

describe "Deck" do
  subject(:deck) { Deck.new }

  context "#initialize" do
    it "makes a deck of 52 cards" do
      expect(deck.cards.size).to eq(52)
    end

    it "calls shuffle" do
      expect_any_instance_of(Array).to receive(:shuffle)
      Deck.new
    end

    it "makes a deck of unique cards" do
      expect(deck.cards).to eq(deck.cards.uniq)
    end
  end

  context "#draw" do
    it "returns a card" do
      expect(deck.draw).to be_a(Card)
    end

    it "removes a card from the deck" do
      card = deck.draw
      expect(deck.cards).to_not include(card)
    end

    it "raises an error if deck is empty" do
      52.times { deck.draw }
      expect { deck.draw }.to raise_error("No More Cards")
    end
  end

  context "#reset" do
    before(:each) { deck.reset }

    it "sets the deck to 52 cards" do
      expect(deck.cards.size).to eq(52)
    end

    it "sets the deck to 52 unique cards" do
      expect(deck.cards).to eq(deck.cards.uniq)
    end

    it "shuffles the deck" do
      expect_any_instance_of(Array).to receive(:shuffle)
      deck.reset
    end
  end
end
