require "./lib/node.rb"

class CompleteMe

  attr_reader :word_counter, :current_node, :letters
  attr_accessor :root

  def initialize
    @root = Node.new(nil)
    @word_counter = 0
  end

  def insert(word)
    current_node = @root
    letters = word.split("")
    letters.each do |letter|
      if current_node.children.key?(letter)
        current_node = current_node.children.dig(letter)
      else
        current_node.children[letter] = Node.new(letter)
        current_node = current_node.children[letter]
      end
    end
    current_node.term = true
    @word_counter += 1
  end

  def count
   @word_counter
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      word_array = word.split("\n")
      word_array.each do |item|
        insert(item.strip)
      end
    end
  end

  def suggest(substring)
    all_words = find_words(substring.chop, end_node_have?(substring))
    p all_words
  end

  def end_node_have?(substring)
    current_node = @root
    letters = substring.split("")
    until current_node.data == substring[-1]
      letters.each do |letter|
        current_node = current_node.children[letter]
      end
    end
    current_node
  end

  def find_words(substring, current_node, words = [])
    word = substring + current_node.data
    words << word if current_node.term && words.length < 5
    current_node.children.each do |key, value|
      find_words(word, value, words)
    end
    words
  end

end
