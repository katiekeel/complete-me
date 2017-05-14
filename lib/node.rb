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
    false
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
