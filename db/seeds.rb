Station.destroy_all

csv_text = File.read('db/stops.csv')
csv = CSV.parse(csv_text, :headers => true)
set = csv.map do |row|
  row
end

set.each do |station|
	Station.create({
		stop_id: station["stop_id"],
		stop_name: station["stop_name"],
		stop_lon: station["stop_lon"],
		stop_lat: station["stop_lat"],
		stop_url: station["stop_url"]
	})
end