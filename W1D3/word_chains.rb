require 'set'
class WordChainer

  def initialize(dictionary_file_name = 'dictionary.txt')
    dictionary = File.readlines(dictionary_file_name).map(&:chomp)
    @dictionary = Set.new(dictionary)
    @steps = initialize_steps(dictionary)
  end

  def initialize_steps(dictionary)
    steps = Hash.new { |h, k| h[k] = [] }
      dictionary.each do |word|
        (0...word.length).each do |i|
          wdup = word.dup
          wdup[i] = '\0'
          steps[wdup] << word
        end
      end
    steps
  end

  def adjacent_words(word)
    words = []
    (0...word.length).each do |i|
      wdup = word.dup
      wdup[i] = '\0'
      words += @steps[wdup]
    end
    words
  end

  # def adjacent_words(word)
  #   @dictionary.select { |entry| one_off?(word, entry) }
  # end
  #
  # def one_off?(word_one, word_two)
  #   return false unless word_one.length == word_two.length
  #
  #   num_differences = 0
  #   word_one.length.times do |i|
  #     num_differences += 1 unless word_one[i] == word_two[i]
  #   end
  #   num_differences == 1
  # end

  def run(source_word, target)
    @current_words = [source_word]
    @all_seen_words = { source_word => nil }

    until @current_words.empty? || @all_seen_words.include?(target)
      new_current_words = explore_current_words
      # new_current_words.take(3).each do |word|
      #   puts "#{word} from #{@all_seen_words[word]}"
      # end
      @current_words = new_current_words
    end
    build_path(target)
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent = adjacent_words(word)
      adjacent.each do |adj_word|
        unless @all_seen_words.include?(adj_word)
          new_current_words << adj_word
          @all_seen_words[adj_word] = word
        end
      end
    end

    new_current_words
  end

  def build_path(target)
    path = [target]
    until path.first.nil?
      path.unshift(@all_seen_words[path.first])
    end
    path
  end

end


if __FILE__ == $PROGRAM_NAME
  word_chainer = WordChainer.new()
  puts 'Source word?'
  source_word = gets.chomp
  puts 'Target word?'
  target_word = gets.chomp
  start = Time.new
  puts word_chainer.run(source_word, target_word)
  end_time = Time.new
  time_passed = end_time - start
  puts "The search took #{time_passed} seconds"
end
