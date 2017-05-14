# Creating the class Node
# This class is the behind-the-scenes insertion and detection heavy lifting
# The methods in Trie call the methods from node

class Node

  # The attributes of node are data, which is the letter the node holds
  # Children, an array of all the this node's children (and their letters)
  # Term, which is a true/false that indicates whether the node chain is over,
  # and therefore whether the word is its own word or not

  # Data and children are attr_readers, since our methods only need to be able
  # to see their contents

  attr_reader :data, :children

  # Term is an accessor, since once a word is complete we'll need to change it
  # in order to signify whether it's its own word or not
  # This happens within Trie, which needs access to the attribute

  attr_accessor :term

  # We initialize a node with a single letter - when we insert a word into the tree,
  # we'll iterate through its letters and pass them as the argument to the new node initialize

  def initialize(data)
    @data = data
    @children = []
    @term = false
  end

  # Nodes need a way to create children (and grandchildren, and great-grandchildren, etc) with the
  # characters we pass them

  def node_insert(letter)
    # If the letter already exists under this node, we don't need to make a new node for it
    if node_have?(letter) == true
      # Tell us that it already exists by calling node_get, which will return the letter itself if it's already there
      return node_get(letter)
    end
    # If the letter doesn't yet exist in the chain:
    # We'll just continue down its child chain until we find another letter in the word that doesn't yet exist in the chain
    # Then we'll make a new branch for that letter and its children
    child = Node.new(letter)
    # We want to put the new child node into the children attribute, which holds all the children of this node for use
    # in future methods
    @children << child
    child
  end

  # Nodes need a way to know if a letter already exists in their chain so they can know whether to branch off or not

  def node_have?(letter)
    # For each child of the node we're on,
    @children.each do |char|
      # If the child's data is the same as the letter we're trying to insert, return true
      # This is used above in insert to create node chains
      return true if char.data == letter
    end
  end

  # Nodes need a way to retrieve the letters in their children chains
  def node_get(letter)
    # For each of the node's child in children,
    @children.each do |child|
      # Give us the child back if the child's data is the same as the letter
      # we're searching for
      return child if child.data == letter
    end
    # Otherwise, return false
    false
  end

end

# Creating the class Trie

class Trie

 # Our methods will be able to read the root node, which is a master placeholder
 # for all the other nodes

  attr_accessor :root

  # When we create a tree, its master root is a new, empty node that will only
  # ever hold children and not its own data

  def initialize
    @root = Node.new(nil)
  end

  # We need a way to insert words into the tree

  def insert(word)
    # We set the current node to the root, which is nil
    node = @root
    # We iterate over each character in the word
    word.length.times do |char|
      # And create a child variable, which we pass node into, and then call
      # the node_insert method from the node class
      # It jumps back up to that method and goes through the child-chain logic
      # Then sets the current node to its child and goes again until we're out of letters
      # Again, it does this process for each letter of the word we're inserting
      child = node.node_insert(word[char])
      node = child
    end
    # Finally, we set the node's term attribute (from the node class) to true, to signify
    # that it is its own word - we'll use this attribute below in have?
    node.term = true
  end

  # We need a way to know whether or not a word exists within our tree
  def have?(word)
    # We start at the root node
    node = @root
    # We iterate through the word's letters
    word.length.times do |letter|
      # And for each letter in the word,
      # We return false unless the node has the letter we're searching for
      # To do this we call the node_have? method from above on the current node
      return false unless node.node_have?(word[letter])
      # If the unless condition is triggered, and the letter exists in the chain
      # Then we set the current node to the next node in the chain
      node = node.node_get(word[letter])
    end
    # We return that the word does exist, unless the false was triggered above
    node.term == true
  end

end
