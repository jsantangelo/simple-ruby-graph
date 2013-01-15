class Edge
	attr_accessor :node1, :node2, :weight
	attr_accessor :id

	def initialize node1, node2, weight, id
		@node1 = node1
		@node2 = node2
		@weight = weight
		@id = id
	end

	def callback

	end
end