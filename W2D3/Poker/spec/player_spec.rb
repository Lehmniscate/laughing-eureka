require 'player'

describe "Player" do
  subject(:player) { Player.new(cards, money)}
  let(:card) {double("card")}
  let(:dcard1) {double("card")}
  let(:dcard2) {double("card")}
  let(:dcard3) {double("card")}
  context "#initialize" do
    it "makes a hand" do
      expect(player.hand).to be_a(Hand)
    end

    it "makes a pot of 100" do
      expect(player.pot).to eq(100)
    end

    it "sets bet to zero" do
      expect(player.bet).to eq(0)
    end
  end

  context "#deal_card" do
    it "adds dealt card to hand" do
      player.deal_card(card)
      expect(player.hand.cards).to include(card)
    end
  end

  context "#make_bet" do
    let(:game) { double('game', pot: 100)}

    it "folds" do
      expect(player.bet).to eq(0)
    end

    it "raises" do
      player.bet(40)
      expect(player.bet).to eq(40)
      expect(player.pot).to eq(60)
    end

    it "sees" do
      player.bet(10)
      expect(player.bet).to eq(game.pot-10)
    end
  end

  context "#choose_to_discard" do
    before(:each) do
      player.deal_card(dcard1)
      player.deal_card(dcard2)
    end

    it "discards a number of cards" do
      player.choose_to_discard(dcard1)
      expect(player.hand.cards).to_not include(dcard1)
    end

    it "draws a number of cards" do
      player.choose_to_discard(dcard1)
      expect(player.hand.cards.count).to eq(2)
    end
  end
end
