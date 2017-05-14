require 'pry'

class Node

  attr_reader :data, :children

  attr_accessor :term

  def initialize(data)
    @data = data
    @children = []
    @term = false
  end

  def node_insert(letter)
    letter = letter.downcase
    if node_have?(letter) == true
      return node_get(letter)
    else
      child = Node.new(letter)
      @children << child
    end
    child
  end


  def node_have?(letter)
    letter = letter.downcase
    @children.each do |child|
      if letter == child.data
        return true
      end
    end
  end

  def node_get(letter)
    letter = letter.downcase
    @children.each do |child|
      if letter == child.data
        return child
      end
    end
   false
  end

end

class Trie

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
    if current_node.term == true
      puts true
      return true
    else
      puts false
      return false
    end
  end

  def suggest(string)
    

  def count
    puts @word_counter
  end

  def populate(dictionary)
    dictionary.each_line do |word|
        insert(word.strip)
    end
  end


end
