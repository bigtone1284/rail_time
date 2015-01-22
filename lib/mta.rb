module MTA

	API_KEY = ENV['MTA_KEY']
	def trains(line_number)
	address = "https://mnorth.prod.acquia-sites.com/wse/gtfsrtwebapi/v1/gtfsrt/#{ENV["MTA_API"]}/getfeed"
	headers = { 'Accept' => 'application/x-protobuf' }
	trains = HTTParty.get(address, :options => {'headers' => headers})
	trains["entity"].select do |train| 
		if train["trip_update"]["trip"]["route_id"] == line_number
			train
		end		
	end	
end

		def direction_filter(line_number, direction)
			trains_set = trains(line_number)
			line_number = line_number.to_i
			if direction == 'north'
				if line_number == 3
					trains_set.select do |train| 
						if train["id"].to_i.even?
							train
						end
					end
				elsif line_number == 1 || line_number == 2
					trains_set.select do |train| 
						if train["id"].to_i.odd?
							train
						end
					end
				end
			elsif direction == 'south'
				if line_number == 3
					trains_set.select do |train| 
						if train["id"].to_i.odd?
							train
						end
					end
				elsif line_number == 1 || line_number == 2
					trains_set.select do |train| 
						if train["id"].to_i.even?
							train
						end
					end
				end
			end
		end


end