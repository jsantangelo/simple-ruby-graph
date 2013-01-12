class Road
	attr_accessor :intersection, :distance
	attr_accessor :id

	def initialize intersection, distance, id
		@intersection = intersection
		@distance = distance
		@id = id
	end

	def tick
	end
end