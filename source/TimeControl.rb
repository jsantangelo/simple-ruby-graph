
class MapNotFinalized < Exception; end 

class TimeControl
	attr_accessor :ticks, :start_time, :duration, :running
	attr_accessor :edges, :nodes, :callbackHandlers

	attr_accessor :total_time, :efficiency

	def initialize
		@ticks = 0
		@running = false
		@duration = duration
		@callbackHandlers = Array.new

		@edges = Array.new
		@nodes = Array.new
	end

	def run
		unless @callbackHandlers.length == 0
			@running = true
			@start_time = Time.now
			while @running
				if @duration != 0
					if @ticks < @duration
						tick
						@ticks += 1
					else
						@running = false
					end
				else
					tick
					@ticks += 1
				end
			end

			finish
		end
	end

	def tick
		unless @callbackHandlers.length == 0
			@callbackHandlers.each {|handler|
				handler.callback
			}
		end
	end

	def finish
		puts "Finishing..."
		now = Time.now
		@total_time = now - @start_time

		@efficiency = @ticks/@total_time
	end

	def to_s
		"Run time: #{@ticks} ticks\nEfficiency: #{@efficiency} ticks/sec\n"
	end

	def attachEdge edge
		@edges.push edge
	end

	def attachNode node
		@nodes.push node
	end

	def readyCallbacks
		@edges.each {|edge|
			addCallback edge
		}
		@nodes.each {|node|
			addCallback node
		}
	end

	def addCallback handler
		if handler.respond_to?('callback')
			@callbackHandlers.push handler
		else
			puts "Invalid callback."
		end
	end

	def printCallbacks
		@callbackHandlers.each {|handler|
			puts handler.id
		}
	end

	def alreadyRegistered? object
		found = false
		@edges.each {|edge|
			found = true if edge.id == object.id
		}

		@nodes.each {|node|
			found = true if node.id == object.id
		}

		found
	end

end
