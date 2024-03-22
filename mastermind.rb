class Player
  @@guess = []
  @@secret_code = []
  @@possible_colors = ["red", "orange", "green", "yellow", "white", "black"]

  attr_accessor :name, :secret_code, :guess, :possible_colors, :role

  def initialize(name, role)
    @name = name
    @role = role
  end

  def codemaker_turn
    if self.name == "Computer"
      4.times do
        @@secret_code.push(@@possible_colors.sample)
      end
    else
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

  puts "\nPlayer 1, what's your name?"
  p1name = gets.chomp

  for i in 1..Float::INFINITY
    puts "\n#{p1name}, what role do you want - codemaker or codebreaker?"
    p1role = gets.chomp.downcase
    if ["codemaker", "codebreaker"].include?(p1role)
      break
    else
      puts "\nInvalid response. Please answer 'codemaker' or 'codebreaker'..."
    end
  end

  player1 = Player.new(p1name, p1role)
  p2role = p1role == "codemaker" ? "codebreaker" : "codemaker"

  for i in 1..Float::INFINITY
    puts "\nAre you playing against the computer?"
    comp = gets.chomp.downcase
    if ["no", "n"].include?(comp)
      puts "\nPlayer 2, what's your name?"
      p2name = gets.chomp
      player2 = Player.new(p2name, p2role)
    elsif ["yes", "y"].include?(comp)
      player2 = Player.new("Computer", p2role)
    else
      puts "\nInvalid response. Please answer yes or no..."
    end
    break if ["no", "n", "yes", "y"].include?(comp)
  end

  if player1.role == "codemaker"
    player1.codemaker_turn
    player2.codebreaker_turn
  else
    player2.codemaker_turn
    player1.codebreaker_turn
  end
end

Game.new
