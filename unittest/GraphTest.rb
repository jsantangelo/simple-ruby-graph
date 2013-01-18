#!/usr/bin/env ruby

#Unit Test Case for class Graph

require_relative '../source/Node.rb'
require_relative '../source/Edge.rb'
require_relative '../source/CallbackRegistrar.rb'
require_relative '../source/Graph.rb'
require 'set'
require 'test/unit'

class GraphTest < Test::Unit::TestCase

	def setup
		@nodeA = Node.new "A"
		@nodeB = Node.new "B"
		@nodeC = Node.new "C"
	end

	def teardown
		# Nothing to be done
	end

	def test_intialization
		registrar = CallbackRegistrar.new

		assert_not_nil Graph.new.nodes
		assert_not_nil Graph.new.edges
		assert_nil Graph.new.timer
		assert_not_nil Graph.new(registrar).timer
	end

	def test_addNode
		registrar = CallbackRegistrar.new
		graph = Graph.new registrar

		graph.addNode @nodeA
		graph.addNode @nodeB
		graph.addNode @nodeC

		assert_equal 3, graph.nodes.length
		assert_equal 3, registrar.nodes.length
	end

	def test_removeNode
		registrar = CallbackRegistrar.new
		graph = Graph.new registrar

		graph.addNode @nodeA
		graph.addNode @nodeB
		graph.createEdgeBetween @nodeA, @nodeB, 10, "AB"
		graph.removeNode @nodeA

		assert_equal 1, graph.nodes.length
		assert_equal 1, registrar.nodes.length
		assert_equal 0, graph.edges[@nodeA].length
		assert_equal 0, registrar.edges.length
	end

	def test_createEdgeBetween
		registrar = CallbackRegistrar.new
		graph = Graph.new registrar

		graph.addNode @nodeA
		graph.addNode @nodeB
		graph.addNode @nodeC
		graph.createEdgeBetween @nodeA, @nodeB, 10, "AB"
		graph.createEdgeBetween @nodeB, @nodeA, 10, "BA"
		graph.createEdgeBetween @nodeB, @nodeA, 10, "BAdupe" #should fail due to duplicate destination
		graph.createEdgeBetween @nodeB, @nodeC, 10, "BC"
		graph.createEdgeBetween @nodeB, @nodeA, 10, "BC" #should fail due to duplicate name

		assert_equal 2, graph.edges[@nodeB].length
		assert_equal 3, registrar.edges.length
	end

	def test_removeEdgeBetween
		registrar = CallbackRegistrar.new
		graph = Graph.new registrar

		graph.addNode @nodeA
		graph.addNode @nodeB
		graph.createEdgeBetween @nodeA, @nodeB, 10, "AB"
		graph.createEdgeBetween @nodeB, @nodeA, 10, "BA"
		graph.removeEdgeBetween @nodeA, @nodeB

		assert_equal 0, graph.edges[@nodeA].length
		assert_equal 1, graph.edges[@nodeB].length
		assert_equal 1, registrar.edges.length
	end

	def test_printNodes
		assert_respond_to Graph.new, "printNodes"
	end
	
	def test_printEdges
		graph = Graph.new

		assert_raise InvalidNode do
			graph.printEdges @nodeA 
		end 

		graph.addNode @nodeB
		graph.addNode @nodeC
		graph.createEdgeBetween @nodeB, @nodeC, 10, "BC"

		assert_nothing_raised do
			graph.printEdges @nodeB
		end
	end
end
