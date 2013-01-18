#!/usr/bin/env ruby

#Unit Test Case for class Edge

require_relative '../source/Node.rb'
require_relative '../source/Edge.rb'
require "test/unit"

class EdgeTest < Test::Unit::TestCase

	def setup
		@edgeID = "testNode"
		@node1 = Node.new "A"
		@node2 = Node.new "B"
		@weight = 20

		@edge = Edge.new @node1, @node2, @weight, @edgeID
	end

	def teardown
		# Nothing to be done
	end

	def test_intialization
		assert_equal @edge.id, @edgeID
		assert_equal @edge.node1, @node1
		assert_equal @edge.node2, @node2
		assert_equal @edge.weight, @weight
	end

	def test_callback
		assert_respond_to @edge, "callback"
	end

end
