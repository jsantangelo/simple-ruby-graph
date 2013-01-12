#!/usr/bin/env ruby

require 'thread'
require 'set'

require_relative 'TimeControl.rb'
require_relative 'Intersection.rb'
require_relative 'Map.rb'
require_relative 'Road.rb'

puts "Welcome to the Traffic Simulator"

puts "Please specify the configuraton file you would like to use to create the road network:"

#TODO: create map out of config file

timer = TimeControl.new

map = Map.new timer
intersection1 = Intersection.new "int1"
intersection2 = Intersection.new "int2"
intersection3 = Intersection.new "int3"

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
