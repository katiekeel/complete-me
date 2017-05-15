require './lib/trie.rb'

class Node

  attr_reader

  attr_accessor :data, :children, :term

  def initialize(data)
    @data = data
    @children = {}
    @term = false
  end

end
