
class MapNotFinalized < Exception; end 

class TimeControl
	attr_accessor :ticks, :start_time, :duration, :running
	attr_accessor :roads, :intersections, :callbackHandlers

	attr_accessor :total_time, :efficiency

	def initialize
		@ticks = 0
		@running = false
		@duration = duration
		@callbackHandlers = Array.new

		@roads = Array.new
		@intersections = Array.new
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
				handler.tick
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

	def attachRoad road
		@roads.push road
	end

	def attachIntersection intersection
		@intersections.push intersection
	end

	def readyCallbacks
		@roads.each {|road|
			addCallback road
		}
		@intersections.each {|intersection|
			addCallback intersection
		}
	end

	def addCallback handler
		if handler.respond_to?('tick')
			@callbackHandlers.push handler
		else
			puts "Invalid callback."
		end
	end

	def printCallbacks
		@callbackHandlers.each {|callback|
			puts callback.id
		}
	end

end
