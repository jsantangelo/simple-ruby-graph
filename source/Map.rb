
class InvalidIntersection < Exception; end
class NoRoadsDefined < Exception; end

class Map
	attr_accessor :intersections, :roads
	attr_accessor :finalized
	attr_accessor :timer

	def initialize timer
		@intersections = Set.new
		@roads = Hash.new

		@timer = timer
	end

	def addIntersection intersection
		unless (@intersections.add? intersection) == nil
			@timer.attachIntersection intersection
		end
	end

	def removeIntersection intersection
		adjacent = Array.new
		@roads[intersection].each {|road|
			adjacent.push road.intersection
		}
		@roads.delete intersection

		adjacent.each {|adjacentIntersection|
			@roads[adjacentIntersection].delete_if {|road|
				road.intersection.id == intersection.id #why is this necessary?
			}
		}

		@intersections.delete intersection
	end

	def createRoadBetween intersection1, intersection2, distance, id
		if !@intersections.include? intersection1 or !@intersections.include? intersection2
			raise InvalidIntersection, 'Map does not contain at least one of the intersections supplied.'
		end

		tempRoad = Road.new intersection1, intersection2, distance, id

		@roads[intersection1] ||= Array.new
	
		found = false
		@roads[intersection1].each { |road|
			found = true if road.id == tempRoad.id 
		}
		@roads[intersection1].push tempRoad unless found
	
		@roads[intersection2] ||= Array.new
		
		found = false
		@roads[intersection2].each { |road|
			found = true if road.id == tempRoad.id
		}
		@roads[intersection2].push tempRoad unless found

		timer.attachRoad tempRoad unless timer.alreadyRegistered? tempRoad
	end

	def removeRoadBetween intersection1, intersection2
		@roads[intersection1].delete_if {|road|
			road.intersection.id == intersection2.id
		}

		@roads[intersection2].delete_if {|road|
			road.intersection.id == intersection1.id
		}
	end

	def printIntersections
		@intersections.each {|intersection| puts intersection.id}
	end

	def printRoads intersection
		if !@intersections.include? intersection
			raise InvalidIntersection, 'Map does not contain the intersection supplied.'
		end

		@roads[intersection] ||= Array.new
		if @roads[intersection].length == 0
			puts 'Specified intersection does not have any roads.'
		else
			@roads[intersection].each {|road|
				puts "#{intersection.id} --#{road.distance.to_s}-- #{road.intersection.id}"
			}
		end
	end

end