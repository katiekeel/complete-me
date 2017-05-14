require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./lib/node"
require "./lib/trie"

class CompleteMeTest < Minitest::Test

  def test_tree_exists
    completion = CompleteMe.new
    assert_instance_of CompleteMe, completion
  end

  def test_tree_root_data_is_nil
    completion = CompleteMe.new
    assert_nil completion.root.data
  end

  def test_tree_can_have_a_node
    completion = CompleteMe.new
    completion.insert("apple")
    assert 1, completion.count
  end

  def test_tree_can_have_multiple_nodes
    completion = CompleteMe.new
    completion.insert("apple")
    completion.insert("bubble")
    completion.insert("cat")
    assert 3, completion.count
  end

  def test_tree_node_can_have_branches
    completion = CompleteMe.new
    completion.insert("apple")
    completion.insert("application")
    completion.insert("appetizer")
    assert 3, completion.count
  end

  def test_tree_has_an_inserted_word
    completion = CompleteMe.new
    completion.insert("apple")
    completion.insert("application")
    completion.insert("appetizer")
    assert completion.have?("apple")
  end

  def test_tree_does_not_have_a_word
    completion = CompleteMe.new
    completion.insert("apple")
    completion.insert("application")
    completion.insert("appetizer")
    refute completion.have?("app")
  end

  def test_tree_can_be_populated_with_dictionary
    skip
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    assert_equal 235886, completion.count
  end

  def test_tree_does_not_have_word_that_does_not_exist
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    completion.populate(dictionary)
    refute completion.have?("askldjaejifeoafj")
  end
end
