#!/usr/bin/env ruby

require 'thread'
require 'set'
require 'yaml'

class FileNotFound < Exception; end

require_relative 'source/TimeControl.rb'
require_relative 'source/Node.rb'
require_relative 'source/Graph.rb'
require_relative 'source/Edge.rb'

puts "Welcome to the Traffic Simulator"

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

map = Graph.new timer
intersection1 = Node.new "int1"
intersection2 = Node.new "int2"
intersection3 = Node.new "int3"

map.addIntersection intersection1
map.addIntersection intersection2
map.addIntersection intersection3

map.createRoadBetween intersection1, intersection2, 20, "road1"
map.createRoadBetween intersection2, intersection3, 20, "road2"
map.createRoadBetween intersection3, intersection2, 20, "road2"

puts "What duration do you wish to run the Simulator for? (0 for no limit)"

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
