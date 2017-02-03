require 'hand'

describe "Hand" do
  subject(:hand) {Hand.new}
  #straight flush
  let(:card_one) { double("Card", suit: :spades, value: 12) }
  let(:card_two) { double("Card", suit: :spades, value: 11) }
  let(:card_three) { double("Card", suit: :spades, value: 10) }
  let(:card_four) { double("Card", suit: :spades, value: 13) }
  let(:card_five) { double("Card", suit: :spades, value: 14) }
  #four of a kind + 2
  let(:card_six) { double("Card", suit: :clubs, value: 11) }
  let(:card_seven) { double("Card", suit: :diamonds, value: 11) }
  let(:card_eight) { double("Card", suit: :hearts, value: 11) }
  #full house + 4,6,7,8
  let(:card_nine) { double("Card", suit: :clubs, value: 13) }
  #flush + 1,2,3,4
  let(:card_ten) { double("Card", suit: :spades, value: 3) }
  #straight 1,3,4,5,6
  #three of a kind 6,7,8,9,10
  #two pair 4,9,7,8,10
  #one pair 6,7,1,3,10
  #High card 10,9,7,5,1

  context "#initialize" do
    it "creates an array" do
      expect(hand.cards).to be_an(Array)
    end
  end

  context "#add_card" do
    it "raises an error if hand has 5 cards" do
      5.times { hand.add_card(card_one) }
      expect{ hand.add_card(card_two) }.to raise_error("Full Hand")
    end

    it "adds a card" do
      hand.add_card(card_one)
      expect(hand.cards).to include(card_one)
    end
  end

  context "#discard_card" do
    it "removes the given card" do
      hand.add_card(card_one)
      hand.add_card(card_two)
      hand.discard_card(card_one)
      expect(hand.cards).to_not include(card_one)
    end

    it "raises an error if hand is empty" do
      expect{ hand.discard_card(card_one) }.to raise_error("Empty Hand")
    end

    it "raises an error if card is not in hand" do
      hand.add_card(card_one)
      expect{ hand.discard_card(card_two) }.to raise_error("Missing Card")
    end
  end

  context "#hand_value" do
    it "raises an error if hand is not 5 cards" do
      expect{ hand.hand_value }.to raise_error("Incomplete Hand")
    end

    it "finds a straight flush" do
      hand.add_card(card_one)
      hand.add_card(card_two)
      hand.add_card(card_three)
      hand.add_card(card_four)
      hand.add_card(card_five)
      expect(hand.hand_value).to eq(91413121110)
    end

    it "finds a four of a kind" do
      hand.add_card(card_two)
      hand.add_card(card_six)
      hand.add_card(card_seven)
      hand.add_card(card_eight)
      hand.add_card(card_ten)
      expect(hand.hand_value).to eq(81111111103)
    end

    it "finds a full house" do
      hand.add_card(card_four)
      hand.add_card(card_six)
      hand.add_card(card_seven)
      hand.add_card(card_eight)
      hand.add_card(card_nine)
      expect(hand.hand_value).to eq(71111111313)
    end

    it "finds a flush" do
      hand.add_card(card_one)
      hand.add_card(card_two)
      hand.add_card(card_three)
      hand.add_card(card_four)
      hand.add_card(card_ten)
      expect(hand.hand_value).to eq(61312111003)
    end

    it "finds a straight" do
      hand.add_card(card_one)
      hand.add_card(card_three)
      hand.add_card(card_four)
      hand.add_card(card_five)
      hand.add_card(card_six)
      expect(hand.hand_value).to eq(51413121110)
    end

    it "finds three of a kind" do
      hand.add_card(card_six)
      hand.add_card(card_seven)
      hand.add_card(card_eight)
      hand.add_card(card_nine)
      hand.add_card(card_ten)
      expect(hand.hand_value).to eq(41111111303)
    end

    it "finds two pair" do
      hand.add_card(card_four)
      hand.add_card(card_seven)
      hand.add_card(card_eight)
      hand.add_card(card_nine)
      hand.add_card(card_ten)
      expect(hand.hand_value).to eq(31313111103)
    end

    it "finds one pair" do
      hand.add_card(card_one)
      hand.add_card(card_three)
      hand.add_card(card_six)
      hand.add_card(card_seven)
      hand.add_card(card_ten)
      expect(hand.hand_value).to eq(21111121003)
    end

    it "finds high card" do
      hand.add_card(card_one)
      hand.add_card(card_five)
      hand.add_card(card_seven)
      hand.add_card(card_nine)
      hand.add_card(card_ten)
      expect(hand.hand_value).to eq(11413121103)
    end
  end
end
