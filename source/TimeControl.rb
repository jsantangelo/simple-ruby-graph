class TimeControl
	attr_accessor :ticks, :start_time, :duration, :running
	attr_accessor :tickreceiver

	attr_accessor :total_time, :efficiency

	def initialize(duration = 0)
		@ticks = 0
		@running = false
		@duration = duration
	end

	def run
		unless @tickreceiver.nil?
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
		unless @tickreceiver.nil?
			@tickreceiver.tick
		end
	end

	def finish
		puts "Finishing..."
		now = Time.now
		@total_time = now - @start_time

		@efficiency = @ticks/@total_time
	end

	def attachReceiver(receiver)
		if receiver.respond_to?('tick')
			@tickreceiver = receiver
		else
			puts "Invalid callback."
		end
	end

	def to_s
		"Run time: #{@ticks} ticks\nEfficiency: #{@efficiency} ticks/sec\n"
	end

end
