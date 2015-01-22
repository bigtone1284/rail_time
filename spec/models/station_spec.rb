require 'rails_helper'

describe Station do 
	it { is_expected.to validate_presence_of :stop_id }
	it { is_expected.to validate_presence_of :stop_name }
	it { is_expected.to validate_presence_of :stop_lat }
	it { is_expected.to validate_presence_of :stop_lon }
	it { is_expected.to validate_presence_of :stop_url }
	it { is_expected.to validate_presence_of :line_name }
	
	it { is_expected.to validate_uniqueness_of :stop_id }
	it { is_expected.to validate_uniqueness_of :stop_name }
	it { is_expected.to validate_uniqueness_of :stop_lat }
	it { is_expected.to validate_uniqueness_of :stop_lon }
	it { is_expected.to validate_uniqueness_of :stop_url }

	let(:valid_station) { new_location = Station.create(
		stop_id: "1",
		stop_name: "Grand Central",
		stop_lat: "40.752998",
		stop_lon: "-73.977056",
		stop_url: "http://as0.mta.info/mnr/stations/station_detail.cfm?key=1",
		line_name: "All"
	)}

	let(:no_stop_id) { nowhere = Station.create(
		stop_id: nil,
		stop_name: "Grand Central",
		stop_lat: "40.752998",
		stop_lon: "-73.977056",
		stop_url: "http://as0.mta.info/mnr/stations/station_detail.cfm?key=1",
		line_name: "All"
	)}

	let(:no_stop_name) { nowhere = Station.create(
		stop_id: '1',
		stop_name: nil,
		stop_lat: "40.752998",
		stop_lon: "-73.977056",
		stop_url: "http://as0.mta.info/mnr/stations/station_detail.cfm?key=1",
		line_name: "All"
	)}

	let(:invalid_line_name) { nowhere = Station.create(
		stop_id: '1000',
		stop_name: "My home",
		stop_lat: "40.752998",
		stop_lon: "-73.977056",
		stop_url: "http://as0.mta.info/mnr/stations/station_detail.cfm?key=1",
		line_name: "Potato"
	)}

	let(:same_id) { nowhere = Station.create(
		stop_id: '1001',
		stop_name: "My home",
		stop_lat: "40.752998",
		stop_lon: "-73.977056",
		stop_url: "http://as0.mta.info/mnr/stations/station_detail.cfm?key=1",
		line_name: "Haven"
	)}

	let(:same_id_2) { nowhere = Station.create(
		stop_id: '1001',
		stop_name: "My homea",
		stop_lat: "40.752998a",
		stop_lon: "-73.977056a",
		stop_url: "http://as0.mta.info/mnr/stations/station_detail.cfm?key=1a",
		line_name: "New Haven"
	)}

	it "saves a valid station" do 
		expect(valid_station).to be_valid
	end

	it "needs to have a stop_id" do
		expect(no_stop_id).to_not be_valid
	end

	it "needs to have a stop_name" do
		expect(no_stop_name).to_not be_valid
	end

	it "must have a valid line name" do 
		expect(invalid_line_name).to_not be_valid
	end

	it "must have a unique stop_id" do
		expect(same_id).to be_valid
		expect(same_id_2).to_not be_valid
	end
end