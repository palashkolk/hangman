require_relative 'computer'
require_relative 'player'

class Game
  def initialize
    puts 'The game is starting!'
    set_up_game
  end

  def play
    loop do
      declare_status
      @player_guess = @player.make_guess
      update_dashboard(@player_guess)
      break if @count_left < 1 || @secret_word == @secret_word_dashboard.join('')
    end

    if @secret_word_dashboard.include?('_')
      puts "You loose! The secret word was: #{@secret_word}"
    elsif @secret_word == @secret_word_dashboard.join('')
      puts "Congratulations! You have correctly guessed the secret word: #{@secret_word} "
    end
  end

  private

  def declare_status
    @current_count += 1
    @count_left = @max_count - @current_count
    puts "\n#{@count_left} count left to guess!"
  end

  def update_dashboard(player_guess)
    if @secret_word_dashboard.include?(player_guess) or @wrong_letter_dashboard.include?(player_guess)
      puts 'Letter already tried!'
    elsif @secret_word_array.include?(player_guess)
      index_array = @secret_word_array.each_index.select { |index| @secret_word_array[index] == player_guess }
      index_array.each do |i|
        @secret_word_dashboard[i] = player_guess
      end
    else
      @wrong_letter_dashboard.push(player_guess)
    end
    puts @secret_word_dashboard.join(' ')
    puts "Wrong letters already tried: #{@wrong_letter_dashboard.join(', ')}"
  end

  def set_up_game
    @player = Player.new('Sabir')
    @wrong_letter_dashboard = []
    @secret_word = Computer.fetch_a_word
    @secret_word_array = @secret_word.split('')
    @secret_word_length = @secret_word.length
    puts "\nComputer has chosen a secret word containing #{@secret_word_length} letters!"
    puts 'Try to guess it!'
    @max_count = 12
    @current_count = 0
    @secret_word_dashboard = Array.new(@secret_word_length) { '_' }
  end
end
