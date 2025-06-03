class Computer
  def self.fetch_a_word
    lines = File.readlines('./dictionary/google-10000-english-no-swears.txt', chomp: true)
    words = lines.select { |word| word.length > 4 && word.length < 13 }
    words.sample
  end
end

puts Computer.fetch_a_word
