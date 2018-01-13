module RandomData
  def self.random_paragraph
    sentences = []
    rand(4..6).times do
      sentences << random_sentence
    end

    sentences.join(" ")
  end

  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  def self.random_word
    # Create an alphabet array
    letters = ('a'..'z').to_a
    # Shuffle the letters in place
    letters.shuffle!
    # Grab index 0 to 3..8 from array
    letters[0,rand(3..8)].join
  end
end
