require './lib/node_hash.rb'

class CompleteMe

  attr_reader :word_counter

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
      current_node = current_node.node_insert(letter)
    end
    end
    current_node.term = true
    @word_counter += 1
  end

  def have?(word)
    current_node = @root
    letters = word.split("")
    unless current_node.children == true
      letters.each do |letter|
        if current_node.children.key?(letter)
          current_node = current_node.children.dig(letter)
        end
      end
    end
    return current_node.term
  end

  def count
    @word_counter
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      word_array = word.split
      word_array.each do |item|
        insert(item.strip)
      end
    end
  end

  def suggest(word)
    letters = word.split("")
  end

end
