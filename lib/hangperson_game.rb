class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :guesses
  attr_accessor :word
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @tries = 0
  end

  def guess(letter)
    raise ArgumentError unless letter != nil
    raise ArgumentError if letter.length == 0
    raise ArgumentError if letter =~ /[^a-z]/i

    if @guesses.downcase.include? letter.downcase or @wrong_guesses.downcase.include? letter.downcase
      return false
    end  
    
    if @word.downcase.include? letter.downcase
      @guesses << letter
    else
      @wrong_guesses << letter
      @tries += 1
    end
    
    return true
  end  
  
  def guess_several_letters(letters)
    
  end
  
  def word_with_guesses
    running_word = ''
    @word.split("").each do |letter|
      if @guesses.include? letter
        running_word << letter
      else
        running_word << "-"
      end
    end
      
    return running_word
  end 
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    else
      if @word == word_with_guesses
        return :win
      else
        return :play
      end
    end
    
  end
  
end
