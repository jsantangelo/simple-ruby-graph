
class InvalidIntersection < Exception; end
class NoRoadsDefined < Exception; end

Road = Struct.new(:intersection, :distance)

class Map
	attr_accessor :intersections

	def initialize
		@intersections = Set.new
		@roads = Hash.new
	end

	def addIntersections *intersections
		@intersections.merge intersections
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

	def createRoadBetween intersection1, intersection2, distance
		if !@intersections.include? intersection1 or !@intersections.include? intersection2
			raise InvalidIntersection, 'Map does not contain at least one of the intersections supplied.'
		end

		@roads[intersection1] ||= Array.new
		if @roads[intersection1].length == 0
			@roads[intersection1].push Road.new(intersection2, distance)
		else
			found = false
			@roads[intersection1].each { |road|
				found = true if road.intersection == intersection2
			}
			@roads[intersection1].push Road.new(intersection2, distance) unless found
		end

		@roads[intersection2] ||= Array.new
		if @roads[intersection2].length == 0
			@roads[intersection2].push Road.new(intersection1, distance)
		else
			found = false
			@roads[intersection2].each { |road|
				found = true if road.intersection == intersection1
			}
			@roads[intersection2].push Road.new(intersection1, distance) unless found
		end		
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