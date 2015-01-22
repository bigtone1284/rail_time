class Station < ActiveRecord::Base
	has_many :alerts
	validates_presence_of 	:stop_id, :stop_name, :stop_lat, :stop_lon, :stop_url, :line_name
	validates_uniqueness_of :stop_id, :stop_name, :stop_lat, :stop_lon, :stop_url
	validate :has_valid_line_name

	def has_valid_line_name
    if !['All', 'Hudson', 'Harlem', 'New Haven'].include?(line_name)
      errors.add(:line_name, "Line name must be valid.")
    end
  end

  def initialize(attributes={})
  	super
  	all = ["1", "4"]
  	hudson = [
  		"9",
  	 	"10",
  	 	"11",
  	 	"14",
  	 	"16",
  	 	"17",
  	 	"18",
  	 	"19",
  	 	"20",
  	 	"22",
  	 	"23",
  	 	"24",
  	 	"25",
  	 	"27",
  	 	"29",
  	 	"30",
  	 	"31",
  	 	"33",
  	 	"37",
  	 	"39",
  	 	"40",
  	 	"42",
  	 	"43",
  	 	"44",
  	 	"46",
  	 	"49",
  	 	"51"
  	]
  	harlem = [
  	 	"55",
  	 	"56",
  	 	"57",
  	 	"58",
  	 	"59",
  	 	"61",
  	 	"62",
  	 	"64",
  	 	"65",
  	 	"66",
  	 	"68",
  	 	"71",
  	 	"72",
  	 	"74",
  	 	"76",
  	 	"78",
  	 	"79",
  	 	"80",
  	 	"81",
  	 	"83",
  	 	"84",
  	 	"85",
  	 	"86",
  	 	"88",
  	 	"89",
  	 	"90",
  	 	"91",
  	 	"94",
  	 	"97",
  	 	"98",
  	 	"99",
  	 	"100",
  	 	"101",
  	 	"176",
  	 	"177"
  	]
  	new_haven = [
  		"105",
  		"106",
  		"108",
  		"110",
  		"111",
  		"112",
  		"114",
  		"115",
  		"116",
  		"118",
  		"120",
  		"121",
  		"124",
  		"153",
  		"154",
  		"155",
  		"157",
  		"127",
  		"128",
  		"129",
  		"131",
  		"158",
  		"160",
  		"161",
  		"162",
  		"163",
  		"164",
  		"165",
  		"133",
  		"134",
  		"136",
  		"137",
  		"138",
  		"188",
  		"140",
  		"143",
  		"167",
  		"168",
  		"169",
  		"170",
  		"171",
  		"172",
  		"145",
  		"190",
  		"149",
  		"151"
  	]
  	if all.include?(self.stop_id)
  		self.line_name = "All"
  	elsif hudson.include?(self.stop_id)
  		self.line_name = "Hudson"
  	elsif harlem.include?(self.stop_id)
  		self.line_name = "Harlem"
  	elsif new_haven.include?(self.stop_id)
  		self.line_name = "New Haven"
  	end
  end

end