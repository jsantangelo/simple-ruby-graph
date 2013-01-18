#!/usr/bin/env ruby

#Unit Test Case for class Node

require_relative '../source/Node.rb'
require "test/unit"

class NodeTest < Test::Unit::TestCase

	def setup
		@nodeID = "testNode"
		@node = Node.new @nodeID
	end

	def teardown
		# Nothing to be done
	end

	def test_intialization
		assert_equal @node.id, @nodeID
	end

	def test_callback
		assert_respond_to @node, "callback"
	end

end
