class HumanPlayer

  def initialize(name)
    @name = name
  end

  def get_guess
    puts "What card would you like to reveal?"
    gets.chomp.split(",").map(&:to_i)
  end

  def receive_match(matches)
  end

  def receive_revealed_card(pos, value)
  end

end
