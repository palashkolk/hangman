class Player
  attr_reader :name

  def initialize(name = 'player')
    @name = name
  end

  def make_guess
    letters = 'a'..'z'
    guess = ''
    print 'Enter your guess letter: '
    loop do
      guess = gets.chomp.downcase
      break if letters.include?(guess)

      puts 'Invalid guess. Please choose exactly one letter!'
    end
    guess
  end
end
