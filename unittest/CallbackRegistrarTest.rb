#!/usr/bin/env ruby

#Unit Test Case for class Graph

require_relative '../source/Node.rb'
require_relative '../source/Edge.rb'
require_relative '../source/CallbackRegistrar.rb'
require 'test/unit'

class GraphTest < Test::Unit::TestCase

	def setup
		@nodeA = Node.new "A"
		@nodeB = Node.new "B"
		@edge = Edge.new @nodeA, @nodeB, 20, "AB"
	end

	def teardown
		# Nothing to be done
	end

	def test_intialization
		registrar = CallbackRegistrar.new

		assert_equal 0, registrar.ticks
		assert_equal false, registrar.running
		assert_equal 0, registrar.duration

		assert_not_nil registrar.callbackHandlers
		assert_not_nil registrar.edges
		assert_not_nil registrar.nodes
	end

	def test_setupAndRun
		registrar = CallbackRegistrar.new

		registrar.attachNode @nodeA
		registrar.attachNode @nodeB
		registrar.detachNode @nodeB
		registrar.attachEdge @edge
		registrar.readyCallbacks
		registrar.duration = 10
		registrar.run

		assert_equal registrar.duration, registrar.ticks
		assert registrar.alreadyRegistered?(@nodeA)
	end

end
