require './lib/node.rb'

class CompleteMe

  attr_reader :word_counter

  attr_accessor :root

  def initialize
    @root = Node.new(nil)
    @word_counter = 0
  end

  def insert(word)
    current_node = @root
    word = word.downcase
    word.length.times do |char|
      child = current_node.node_insert(word[char])
      current_node = child
    end
    current_node.term = true
    @word_counter += 1
  end

  def have?(word)
    current_node = @root
    word.length.times do |char|
      return false unless current_node.node_have?(word[char])
      current_node = current_node.node_get(word[char])
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

end
