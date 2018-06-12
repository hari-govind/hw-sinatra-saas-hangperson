require 'byebug'

class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  def guess(letter)
    match = letter =~ /^[a-z]$/i
    raise(ArgumentError) unless match != nil
    letter.downcase!
    return false if letter.empty? or letter.size > 1 or @guesses.downcase.include? letter or @wrong_guesses.downcase.include? letter
    if @word.downcase.include? letter
      @guesses = @guesses + letter
      true
    else
      @wrong_guesses = @wrong_guesses + letter
      true
    end
  end
  def word_with_guesses
    @word.chars.map do |letter|
      if @guesses.include? letter
        letter
      else
        "-"
      end
    end.join("")
  end

  #getters and setters
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
end