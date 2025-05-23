require_relative 'computer'
require_relative 'player'

class Game
  def initialize
    puts 'The game is starting!'
    set_up_game
  end

  def play
    player = Player.new('Sabir')
    @wrong_array = []
    loop do
      @current_count += 1
      @count_left = @max_count - @current_count
      puts "\n#{@count_left} count left to guess!"
      @player_guess = player.make_guess
      if @empty_array.include?(@player_guess) or @wrong_array.include?(@player_guess)
        puts 'Letter already tried!'
      elsif @secret_array.include?(@player_guess)
        index_array = @secret_array.each_index.select { |index| @secret_array[index] == @player_guess }
        index_array.each do |i|
          @empty_array[i] = @player_guess
        end
      else
        @wrong_array.push(@player_guess)
      end
      puts @empty_array.join(' ')
      puts "Wrong letters already tried: #{@wrong_array.join(', ')}"
      break if @count_left < 1 || @secret_word == @empty_array.join('')
    end
    if @empty_array.include?('_')
      puts "You loose! The secret word was: #{@secret_word}"
    elsif @secret_word == @empty_array.join('')
      puts "Congratulations! You have correctly guessed the secret word: #{@secret_word} "
    end
  end

  def set_up_game
    @secret_word = Computer.fetch_a_word
    @secret_array = @secret_word.split('')
    @secret_word_length = @secret_word.length
    puts "\nComputer has chosen a secret word containing #{@secret_word_length} letters!"
    puts 'Try to guess it!'
    @max_count = 12
    @current_count = 0
    @empty_array = Array.new(@secret_word_length) { '_' }
  end
end
new_game = Game.new
new_game.play
