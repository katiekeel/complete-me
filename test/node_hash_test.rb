require 'pry'
require './lib/trie.rb'

trie = CompleteMe.new
dictionary = File.read("/usr/share/dict/words")
trie.populate(dictionary)
trie.count
trie.have?("xylophone")
