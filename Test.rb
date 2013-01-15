#!/usr/bin/env ruby

require 'thread'
require 'set'
require 'yaml'

class FileNotFound < Exception; end

require_relative 'source/CallbackRegistrar.rb'
require_relative 'source/Node.rb'
require_relative 'source/Graph.rb'
require_relative 'source/Edge.rb'

puts "Testing the Simple Ruby Graph"

puts "Please specify the configuraton file you would like to use to create the graph:"

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

graph = Graph.new registrar
node1 = Node.new "A"
node2 = Node.new "B"
node3 = Node.new "C"
node4 = Node.new "D"

graph.addNode node1
graph.addNode node2
graph.addNode node3
graph.addNode node4

graph.createEdgeBetween node1, node4, 20, "AD"

graph.printEdges node1

graph.removeNode node4

graph.printNodes
graph.printEdges node1

graph.createEdgeBetween node1, node2, 20, "AB"
graph.createEdgeBetween node2, node3, 20, "BC"
graph.createEdgeBetween node3, node2, 20, "CB"
graph.createEdgeBetween node1, node3, 10, "AC"
graph.removeEdgeBetween node1, node3

puts "Nodes:"
graph.printNodes
puts "Edges (#{node1.id}):"
graph.printEdges node1
puts "Edges (#{node2.id}):"
graph.printEdges node2
puts "Edges (#{node3.id}):"
graph.printEdges node3

puts "What duration do you wish to run the registrar for? (0 for no limit)"

registrar.readyCallbacks

# STDOUT.flush
# duration = gets.chomp.to_i
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
