class ComputerPlayer

  def initialize(row, col)
    @known_cards = {}
    @unknown_cards = populate(row, col)
    @turn = 1
    @current_pos = nil
  end

  def receive_match(matched)
    @known_cards.delete_if do |key, value|
      matched.include?(key)
    end
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def populate(row, col)
    unknown = []
    (0...row).each do |i|
      (0...col).each do |j|
        unknown << [i, j]
      end
    end
    unknown
  end

  def get_guess
    guess = find_matches(@current_pos)
    guess ||= random_guess

    if @turn == 1
      @turn = 2
      @current_pos = guess
    else
      @turn = 1
      @current_pos = nil
    end

    return guess
  end

  def random_guess
    @unknown_cards.pop
  end


  def find_matches(pos = nil)
    cards = @known_cards.values
    pairs = cards.select do |card|
      cards.count(card) > 1
    end
    @known_cards.each do |key, val|
      return key if pairs.include?(val) && key != pos
    end
    nil
  end
end
