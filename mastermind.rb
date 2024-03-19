class Player
  @@guessed_colors = []
  @@colors = []

  attr_accessor :name, :colors, :guessed_colors

  def initialize(name)
    @name = name

  end


  def set_roles

  end

  def codemaker_turn
    # colors = []
    puts "#{self.name}, let's make your secret code!"
    4.times do |i|
      puts "Color #{i+1} - red, blue, green, yellow, white, or black?"
      @@colors[i] = gets.chomp
    end
    puts "#{self.name}, your secret code is #{colors}"
  end

  def codebreaker_turn
    # guessed_colors = []
    12.times do |i| /work in progress; everything inside loop works once/
      puts "#{self.name}, let's make a guess!"
      4.times do |i|
        puts "Guess color ##{i+1} - red, blue, green, yellow, white, or black?"
        @@guessed_colors[i] = gets.chomp
      end
      puts "#{self.name}, your guess is #{@@guessed_colors}"
      check_for_winner(self)
    end
  end

  def check_for_winner(codebreaker)
    if @@guessed_colors == @@colors
      puts "#{codebreaker.name} matched the secret code: #{@@colors}"
      puts "#{codebreaker.name} the Codebreaker wins!"
    end
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
