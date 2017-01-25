require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'

class Game

  def initialize
    @size = Game.get_size
    @board = Board.new(@size.first, @size.last)
    @board.populate
    @player = nil
  end

  def self.get_size
    puts "What board size?"
    gets.chomp.split(",").map(&:to_i)
  end

  def get_player
    puts "Human or Computer?"
    choice = gets.chomp
    if choice == "Human"
      puts "What is your name?"
      HumanPlayer.new(gets.chomp)
    else
      ComputerPlayer.new(@size.first, @size.last)
    end
  end

  def play
    @player = get_player
    until @board.won?
      @board.render
      guess_pos = []
      cards = []

      2.times do
        guess_pos << @player.get_guess
        cards << @board.reveal(guess_pos.last)
        @player.receive_revealed_card(guess_pos.last, cards.last.info)
        @board.render
      end
      # guess_one_pos = @player.get_guess
      # card_one = @board.reveal(guess_one_pos)
      # @player.receive_revealed_card(guess_one_pos, card_one.info)
      # @board.render
      # guess_two_pos = @player.get_guess
      # card_two = @board.reveal(guess_two_pos)
      # @player.receive_revealed_card(guess_two_pos, card_one.info)
      # @board.render

      if cards.first == cards.last
        @player.receive_match(guess_pos)
      else
        cards.map(&:hide)
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
