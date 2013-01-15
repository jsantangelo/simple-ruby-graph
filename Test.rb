#!/usr/bin/env ruby

#This file is meant to test/exercise the various components of the Simple Ruby manualGraph.

require 'thread'
require 'set'
require 'yaml'

class FileNotFound < Exception; end

require_relative 'source/CallbackRegistrar.rb'
require_relative 'source/Node.rb'
require_relative 'source/Graph.rb'
require_relative 'source/Edge.rb'

puts "Testing the Simple Ruby Graph"

puts "=== Testing configuration ==="

puts "Please specify the configuraton file you would like to use to create the manualGraph:"

#STDOUT.flush
# configfile = gets.chomp
configfile = 'basic.yml'

configfile = 'config/' + configfile

unless File.exists? configfile
	raise FileNotFound, 'File does not exist.'
end
thing = YAML.load_file configfile
puts  thing.inspect

#TODO: create map out of config file

registrar = CallbackRegistrar.new

puts "=== Testing Graph ==="
puts ""
manualGraph = Graph.new registrar
node1 = Node.new "A"
node2 = Node.new "B"
node3 = Node.new "C"
node4 = Node.new "D"

manualGraph.addNode node1
manualGraph.addNode node2
manualGraph.addNode node3
manualGraph.addNode node4

manualGraph.createEdgeBetween node1, node4, 20, "AD"

manualGraph.printEdges node1

manualGraph.removeNode node4

manualGraph.printEdges node1

puts ""

manualGraph.createEdgeBetween node1, node2, 20, "AB"
manualGraph.createEdgeBetween node2, node3, 20, "BC"
manualGraph.createEdgeBetween node3, node2, 20, "CB"
manualGraph.createEdgeBetween node1, node3, 10, "AC"
manualGraph.removeEdgeBetween node1, node3

puts "Nodes:"
manualGraph.printNodes
puts "Edges (#{node1.id}):"
manualGraph.printEdges node1
puts "Edges (#{node2.id}):"
manualGraph.printEdges node2
puts "Edges (#{node3.id}):"
manualGraph.printEdges node3

puts ""
puts "Graph without Registrar"
nrGraph = Graph.new
nrGraph.addNode node1
nrGraph.printNodes

puts ""
puts "=== Testing CallbackRegistrar ==="
print "What duration do you wish to run the registrar for? (0 for no limit) "

registrar.readyCallbacks

# STDOUT.flush
# duration = gets.chomp.to_i
puts ""
duration = 1

registrar.duration = duration

callbackThread = Thread.new{
	registrar.run
	Thread.current["result"] = registrar.to_s
}
if duration == 0
	print "Press [Enter] to stop."
	gets
	registrar.running = false
end

callbackThread.join

puts ""
puts "Callback Results:"
puts callbackThread["result"]
