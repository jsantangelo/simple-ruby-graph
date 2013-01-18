
class InvalidNode < Exception; end
class NoEdgesDefined < Exception; end

class Graph
	attr_accessor :nodes, :edges
	attr_accessor :finalized
	attr_accessor :timer

	def initialize timer = nil
		@nodes = Set.new
		@edges = Hash.new

		@timer = timer
	end

	def addNode node
		found = false
		@nodes.each {|existingNode|
			found = true if existingNode.id == node.id
		}

		unless (@nodes.add? node) == nil or found
			@timer.attachNode node unless @timer == nil
			@edges[node] ||= Array.new
		end
	end

	def removeNode node		
		if @edges[node] != nil
			@edges[node].each {|edge|
				@edges[node].delete edge
				@timer.detachEdge edge
			}
		end

		edges.each_key {|node|
			@edges[node].each {|edge|
				if edge.node2.id == node.id
					@edges[node].delete edge
					@timer.detachEdge edge
				end
			}
		}

		@nodes.delete node
		@timer.detachNode node
	end

	def createEdgeBetween node1, node2, weight, id
		if !@nodes.include? node1 or !@nodes.include? node2
			raise InvalidNode, 'Graph does not contain at least one of the nodes supplied.'
		end

		tempEdge = Edge.new node1, node2, weight, id

		@edges[node1] ||= Array.new
	
		found = false
		@edges[node1].each { |edge|
			found = true if edge.node2.id == tempEdge.node2.id or edge.id == tempEdge.id 
		}
		@edges[node1].push tempEdge unless found

		@timer.attachEdge tempEdge unless found or @timer == nil or @timer.alreadyRegistered? tempEdge
	end

	def removeEdgeBetween node1, node2
		edgesToBeRemoved = Array.new
		@edges[node1].delete_if {|edge|
			edgesToBeRemoved.push edge if edge.node2.id == node2.id
			edge.node2.id == node2.id
		}

		edgesToBeRemoved.each {|edge|
			@timer.detachEdge edge
		}
	end

	def printNodes
		@nodes.each {|node| puts node.id}
	end

	def printEdges node
		if !@nodes.include? node
			raise InvalidNode, 'Graph does not contain the node supplied.'
		end

		@edges[node] ||= Array.new
		if @edges[node].length == 0
			puts 'Specified node does not have any edges.'
		else
			@edges[node].each {|edge|
				puts "#{edge.id}: #{edge.node1.id} --#{edge.weight.to_s}-- #{edge.node2.id}"
			}
		end
	end

end