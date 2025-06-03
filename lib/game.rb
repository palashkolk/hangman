require_relative 'computer'
require_relative 'player'
require 'yaml'

class Game
  def initialize
    puts 'The game is starting!'
    set_up_game
  end

  def play
    puts 'Do you want load a saved game? y/n'
    answer = gets.chomp.downcase
    load_game if answer == 'y'
    loop do
      save_game
      @player_guess = @player.make_guess
      update_dashboard(@player_guess)
      show_dashboard_status
      break if @count_left < 1 || @secret_word == @secret_word_dashboard.join('')
    end

    if @secret_word_dashboard.include?('_')
      puts "You loose! The secret word was: #{@secret_word}"
    elsif @secret_word == @secret_word_dashboard.join('')
      puts "Congratulations! You have correctly guessed the secret word: #{@secret_word} "
    end
  end

  private

  def load_game
    saved_files = Dir.glob('saves/*.yml')
    return puts 'no saved games found' if saved_files.empty?

    puts 'Choose a saved game to load:'
    saved_files.each_with_index do |file, index|
      puts "#{index + 1}: #{File.basename(file)}"
    end
    choice = nil
    until choice && choice.between?(1, saved_files.size)
      print 'Enter the number of the file: '
      choice = gets.chomp.to_i
    end
    filename = "#{saved_files[choice - 1]}"
    data = YAML.load_file(filename)
    # game = Game.new
    instance_variable_set(:@secret_word, data[:secret_word])
    instance_variable_set(:@secret_word_array, data[:secret_word_array])
    instance_variable_set(:@secret_word_length, data[:secret_word_length])
    instance_variable_set(:@current_count, data[:current_count])
    instance_variable_set(:@count_left, data[:count_left])
    instance_variable_set(:@secret_word_dashboard, data[:secret_word_dashboard])
    instance_variable_set(:@wrong_letter_dashboard, data[:wrong_letter_dashboard])
    instance_variable_set(:@player_guess, data[:player_guess])
    instance_variable_set(:@max_count, data[:max_count])
    puts 'Game loaded!'
  end

  def save_game
    puts 'Do you want to save the game? y/n'
    choice = gets.chomp.downcase
    return unless choice == 'y'

    data = { secret_word: @secret_word, secret_word_array: @secret_word_array, secret_word_length: @secret_word_length, current_count: @current_count,
             count_left: @count_left, secret_word_dashboard: @secret_word_dashboard, wrong_letter_dashboard: @wrong_letter_dashboard, player_guess: @player_guess, max_count: @max_count }

    make_directory_and_save(data)
  end

  def make_directory_and_save(data)
    Dir.mkdir('saves') unless Dir.exist?('saves')
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    filename = "saves/hangman_#{timestamp}.yml"
    File.open(filename, 'w') do |file|
      file.write(YAML.dump(data))
    end
    puts "Game save as #{filename}. Exiting game ..."
    exit
  end

  def show_dashboard_status
    @current_count += 1
    @count_left = @max_count - @current_count
    puts "\n#{@count_left} count is left to guess!"
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
