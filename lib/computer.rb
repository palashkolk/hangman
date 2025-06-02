class Computer
  def self.fetch_a_word
    word = ''
    loop do
      word = File.readlines('./dictionary/google-10000-english-no-swears.txt').sample.chomp
      break if word.length > 4 && word.length < 13
    end
    word
  end
end
