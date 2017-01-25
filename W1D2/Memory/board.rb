require_relative 'card.rb'


class Board

  def initialize(row, col)
    @board = Array.new(row) { Array.new(col) }

  end

  def populate
    deck = generate_deck.shuffle
    @board.each_with_index do |row, i|
      row.each_index do |j|
        @board[i][j] = deck.pop
      end
    end
  end

  def generate_deck
    num_cards = @board.size * @board.first.size
    deck = (1..num_cards / 2).to_a
    deck += deck
    deck.map { |card| Card.new(card) }
  end

  def won?
    @board.each do |row|
      row.each do |card|
        return false unless card.info
      end
    end
    true
  end

  def render
    @board.each do |row|
      row_output = []
      row.each do |card|
         row_output << card.to_s
      end
      puts row_output.join(" ")
    end
  end

  def reveal(guessed_pos)
    row, col = guessed_pos
    @board[row][col].reveal
    @board[row][col]
  end

end
