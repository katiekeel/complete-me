class Node

  attr_reader :data

  attr_accessor :children, :term

  def initialize(letter)
    @data = letter
    @children = {}
    @term = false
  end

end
