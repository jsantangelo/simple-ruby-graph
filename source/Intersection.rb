class Intersection
	attr_accessor :id

	def initialize id
		@id = id
	end

	def tick
		puts "#{id} ticking..."
	end

end