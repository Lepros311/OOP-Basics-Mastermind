class Player
  @@guess = []
  @@secret_code = []

  attr_accessor :name, :secret_code, :guess

  def initialize(name)
    @name = name

  end


  def set_roles

  end

  def codemaker_turn
    # colors = []
    possible_colors = ["red", "orange", "green", "yellow", "white", "black"]
    puts "#{self.name}, let's make your secret code!"
    4.times do |i|
      puts "Color #{i+1} - red, orange, green, yellow, white, or black?"
      @@secret_code[i] = gets.chomp
      until possible_colors.include?(@@secret_code[i])
        @@secret_code.pop
        puts "That is not a valid option. Please try again."
      end
    end
    puts "#{self.name}, your secret code is #{@@secret_code}"
  end

  def codebreaker_turn
    # guessed_colors = []
    12.times do |i|
      puts "#{self.name}, make a guess!"
      4.times do |i|
        puts "Guess color ##{i+1} - red, orange, green, yellow, white, or black?"
        @@guess[i] = gets.chomp
      end
      puts "#{self.name}, your guess is #{@@guess}"
      break if winner?(self)
      puts "Sorry, guess again!"
      compare_guess_to_secret_code
    end
    puts "#{self.name}, you lose. You were unable to break the secret code :("
  end

  def winner?(codebreaker)
    if @@guess == @@secret_code
      puts "#{codebreaker.name} matched the secret code: #{@@secret_code}"
      puts "#{codebreaker.name} the Codebreaker wins!"
      true
    else
      false
    end
  end

  def compare_guess_to_secret_code
    match_count = 0
    matched_indexes = []
    color_only_count = 0
    @@guess.each_with_index do |color, index|
      if color == @@secret_code[index]
        match_count += 1
        matched_indexes.push(index)
      elsif @@secret_code.include?(color) && !matched_indexes.include?(index)
        color_only_count += 1
      end
    end
    puts "Correct color and location: #{match_count}"
    puts "Correct color only: #{color_only_count}"
  end

end

class Code

  def initialize(color1, color2, color3, color4)
    @colors_arr = [color1, color2, color3, color4]

  end

  def make_secret_code

  end

end

class Guess

  def initialize(guess)
    @guess = guess
  end

  def make_guess

  end

end

class Game
  attr_accessor

  def initialize

  end

  def draw_board

  end



  puts "Codemaker, what's your name?"
  codemaker = Player.new(gets.chomp)

  puts "Codebreaker, what's your name?"
  codebreaker = Player.new(gets.chomp)

  codemaker.codemaker_turn
  codebreaker.codebreaker_turn

end

our_game = Game.new
# our_game.codemaker_turn(@codemaker)
