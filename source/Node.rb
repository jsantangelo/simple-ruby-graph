class Node
	attr_accessor :id

	def initialize id
		@id = id
	end

	def callback
		puts "Node #{id} callback."
	end
end