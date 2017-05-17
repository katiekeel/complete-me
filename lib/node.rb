class Node

  attr_reader :data

  attr_accessor :children, :term

  def initialize(letter)
    @data = letter
    @children = {}
    @term = false
  end

  def node_insert(letter)
    if node_have?(letter) == true
      return node_get(letter)
    else
      child = Node.new(letter)
      @children[letter] = child
    end
    child
  end

  def node_have?(letter)
    @children.each do |key, value|
      if letter == key
        return true
      end
    end
    false
  end

  def node_get(letter)
    @children.each do |key, value|
      if letter == key
        return key
      end
    end
   false
  end

end
