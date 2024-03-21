class Player
  @@guess = []
  @@secret_code = []
  @@possible_colors = ["red", "orange", "green", "yellow", "white", "black"]

  attr_accessor :name, :secret_code, :guess, :possible_colors

  def initialize(name)
    @name = name
  end

  def codemaker_turn
    puts "\n#{self.name}, let's make your secret code!"
    4.times do |i|
      loop do
        puts "Color #{i+1} - red, orange, green, yellow, white, or black?"
        @@secret_code[i] = gets.chomp.downcase
        if @@possible_colors.include?(@@secret_code[i])
          break
        else
          @@secret_code.pop
          puts "That is not a valid option. Please try again."
        end
      end
    end
    puts "#{self.name}, your secret code is #{@@secret_code}"
  end

  def codebreaker_turn
    12.times do |i|
      puts "\n#{self.name}, make a guess! (#{i+1} of 12 guesses)"
      4.times do |i|
        loop do
          if self.name != "Computer"
            puts "Guess color ##{i+1} - red, orange, green, yellow, white, or black?"
          end
          self.name == "Computer" ? @@guess[i] = @@possible_colors.sample : @@guess[i] = gets.chomp.downcase
          if @@possible_colors.include?(@@guess[i])
            break
          else
            @@guess.pop
            puts "That is not a valid option. Please try again."
          end
        end
      end
      puts "\n#{self.name}, your guess is #{@@guess}"
      if winner?(self)
        puts "The secret code is #{@@secret_code}"
        puts "#{self.name} the Codebreaker wins!"
        break
      end
      compare_guess_to_secret_code
    end
    if !winner?(self)
      puts "\n#{self.name}, you lose. You were unable to break the secret code :("
    end
  end

  def winner?(codebreaker)
    @@guess == @@secret_code
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

class Game
  puts "~Mastermind~"

  puts "\nCodemaker, what's your name?"
  codemaker = Player.new(gets.chomp)

  for i in 1..Float::INFINITY
    puts "\n#{codemaker.name}, are you playing against the computer?"
    comp = gets.chomp.downcase
    if ["no", "n"].include?(comp)
      puts "\nCodebreaker, what's your name?"
      codebreaker = Player.new(gets.chomp)
    elsif ["yes", "y"].include?(comp)
      codebreaker = Player.new("Computer")
    else
      puts "\nInvalid response. Please answer yes or no..."
    end
    break if ["no", "n", "yes", "y"].include?(comp)
  end

  codemaker.codemaker_turn
  codebreaker.codebreaker_turn
end

Game.new
