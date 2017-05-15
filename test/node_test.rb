require 'simplecov'
SimpleCov.start
require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "./lib/node"
require "./lib/trie"

require 'pry'

class NodeTest < Minitest::Test

  def test_node_exists
    node = Node.new(nil)
    assert_instance_of Node, node
  end

  def test_node_takes_data
    node = Node.new("a")
    assert_equal "a", node.data
  end

  def test_node_has_no_children_by_default
    node = Node.new(nil)
    assert node.children.empty?
  end

  def test_node_term_is_false_by_default
    node = Node.new(nil)
    refute node.term
  end

  def test_node_can_have_a_child
    node = Node.new("a")
    child_node = node.node_insert("b")
    assert_instance_of Node, child_node
    assert_equal child_node.data, "b"
  end

  def test_node_can_have_a_grandchild
    node = Node.new("a")
    child_node = node.node_insert("b")
    assert_equal child_node.data, "b"
    grandchild_node = child_node.node_insert("c")
    assert_instance_of Node, grandchild_node
    assert_equal grandchild_node.data, "c"
  end

  def test_node_children_exist
    node = Node.new("a")
    node = node.node_insert("b")
    assert_equal node.data, "b"
  end

  def test_insert_node_returns_node
    node = Node.new("a")
    assert node.children.empty?
    child_node = node.node_insert("b")
    assert_equal child_node.data, "b"
    assert_equal node.children.length, 1
    refute node.children.empty?
  end

end
