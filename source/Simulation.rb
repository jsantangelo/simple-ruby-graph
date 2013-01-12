#!/usr/bin/env ruby

require 'thread'
require 'set'

require_relative 'TimeControl.rb'
require_relative 'Intersection.rb'
require_relative 'TrafficLight.rb'
require_relative 'Car.rb'
require_relative 'Map.rb'

# algorithm = 

map = Map.new
intersection1 = Intersection.new "int1"
intersection2 = Intersection.new "int2"
intersection3 = Intersection.new "int3"

map.addIntersections intersection1, intersection2, intersection3

map.createRoadBetween intersection1, intersection2, 20
map.createRoadBetween intersection2, intersection3, 20

# puts "Welcome to the Four-Way Intersection Traffic Simulator"

# puts "What duration do you wish to run the Simulator for? (0 for no limit)"

# STDOUT.flush
# duration = gets.chomp.to_i

# timer = TimeControl.new(duration)
# timer.attachReceiver(intersection)

# timerThread = Thread.new{
# 	timer.run
# 	Thread.current["result"] = timer.to_s
# }
# if duration == 0
# 	print "Press [Enter] to stop."
# 	gets
# 	timer.running = false
# end

# timerThread.join

# puts ""
# puts "Simulation Results:"
# puts timerThread["result"]
