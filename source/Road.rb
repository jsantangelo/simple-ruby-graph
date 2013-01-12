class Road
	attr_accessor :intersection1, :intersection2, :distance
	attr_accessor :id

	def initialize intersection1, intersection2, distance, id
		@intersection1 = intersection1
		@intersection2 = intersection2
		@distance = distance
		@id = id
	end

	def tick
		puts "#{id} ticking..."
	end
end