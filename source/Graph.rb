
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
		unless (@nodes.add? node) == nil
			@timer.attachNode node unless @timer == nil
		end
	end

	def removeNode node
		connectedNodes = Array.new
		
		if @edges[node] != nil
			@edges[node].each {|edge|
				connectedNodes.push edge.node1 unless edge.node1.id == node.id
				connectedNodes.push edge.node2 unless edge.node2.id == node.id
			}
			@edges.delete node
		end

		connectedNodes.each {|connectedNode|
			@edges[connectedNode].each {|edge|
				if edge.node1.id == node.id or edge.node2.id == node.id
					@edges[connectedNode].delete edge
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
			found = true if edge.id == tempEdge.id 
		}
		@edges[node1].push tempEdge unless found
	
		@edges[node2] ||= Array.new
		
		found = false
		@edges[node2].each { |edge|
			found = true if edge.id == tempEdge.id
		}
		@edges[node2].push tempEdge unless found

		@timer.attachEdge tempEdge unless @timer.alreadyRegistered? tempEdge or @timer == nil
	end

	def removeEdgeBetween node1, node2
		edgesToBeRemoved = Array.new
		@edges[node1].delete_if {|edge|
			edgesToBeRemoved.push edge if edge.node2.id == node2.id
			edge.node2.id == node2.id
		}

		@edges[node2].delete_if {|edge|
			edgesToBeRemoved.push edge if edge.node1.id == node1.id
			edge.node1.id == node1.id
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