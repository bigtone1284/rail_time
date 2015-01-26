module MTA

	def self.trains(line_number)
		address = "https://mnorth.prod.acquia-sites.com/wse/gtfsrtwebapi/v1/gtfsrt/#{ENV["MTA_API"]}/getfeed"
		headers = { 'Accept' => 'application/x-protobuf' }
		trains = HTTParty.get(address, :options => {'headers' => headers})
		trains["entity"].select do |train| 
			if train["trip_update"]["trip"]["route_id"] == line_number
				train
			end		
		end	
	end

	def self.direction_filter(line_number, direction)
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

	def self.stop_on_train?(train, stop_id)
		train["trip_update"]["stop_time_update"].each do |stop|
			if stop["stop_id"] == stop_id
				return true
			end
		end
		return false
	end

	def self.trains_stop(trains, stop_id)
		trains.select do |train|
			if stop_on_train?(train, stop_id)
				train
			end
		end
	end

	def self.find_stop(stop_listing, stop_id)
		stop_listing.select do |stop|
			if stop["stop_id"] == stop_id
				stop
			end
		end
	end

	def self.station_info(trains, stop_id)
		trains.map do |train|
			stop_info = find_stop(train["trip_update"]["stop_time_update"], stop_id)
			train_time = train["trip_update"]["trip"]["start_time"]
			trainone = stop_info[0].merge({train_id: train['id']}).merge({train_time: train_time})
		end
	end

	def self.current_station(line_number, direction, stop_id)
		trains = direction_filter(line_number, direction)
		train_filter = trains_stop(trains, stop_id)
		stations = station_info(train_filter, stop_id)
	end

	def self.station_update(stop_id, direction)
		stop = Station.find_by stop_id: stop_id
		stops = {"Hudson" => "1", "Harlem" => "2", "New Haven" => "3"}
		stop_name = stop.line_name
		formatter(current_station(stops[stop_name], direction, stop_id))
	end

	def self.formatter(update_array)
		update_array.map do |update|
			{
				train_id: update[:train_id],
				etd: update[:train_time].partition(/\d\d/).select(&:present?).join(":"),
				scheduled_arrival: Time.at(update["departure"]["time"]).strftime('%H:%M'),
				updated_arrival: Time.at(update["departure"]["time"] + update["departure"]["delay"]).strftime('%H:%M')
			}
		end
	end


end