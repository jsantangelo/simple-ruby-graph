#!/usr/bin/env ruby

require 'thread'
require 'set'
require 'yaml'

class FileNotFound < Exception; end

require_relative 'source/TimeControl.rb'
require_relative 'source/Node.rb'
require_relative 'source/Graph.rb'
require_relative 'source/Edge.rb'

puts "Testing the Simple Ruby Graph"

puts "Please specify the configuraton file you would like to use to create the road network:"

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

timer = TimeControl.new

graph = Graph.new timer
node1 = Node.new "A"
node2 = Node.new "B"
node3 = Node.new "C"

graph.addIntersection node1
graph.addIntersection node2
graph.addIntersection node3

graph.createRoadBetween node1, node2, 20, "AB"
graph.createRoadBetween node2, node3, 20, "BC"
graph.createRoadBetween node3, node2, 20, "CB"

puts "What duration do you wish to run the timer for? (0 for no limit)"

timer.readyCallbacks

# STDOUT.flush
# duration = gets.chomp.to_i
duration = 1

timer.duration = duration

timerThread = Thread.new{
	timer.run
	Thread.current["result"] = timer.to_s
}
if duration == 0
	print "Press [Enter] to stop."
	gets
	timer.running = false
end

timerThread.join

puts ""
puts "Simulation Results:"
puts timerThread["result"]
