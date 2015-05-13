class Station < ActiveRecord::Base
	has_many :alerts
	validates_presence_of 	:stop_id, :stop_name, :stop_lat, :stop_lon, :stop_url, :line_name
	validates_uniqueness_of :stop_id, :stop_name, :stop_lat, :stop_lon, :stop_url
	validate :has_valid_line_name

	self.lines = 

	def has_valid_line_name
    if !['All', 'Hudson', 'Harlem', 'New Haven'].include?(line_name)
      errors.add(:line_name, "Line name must be valid.")
    end
  end

  def initialize(attributes={})
  	super
  	lines = {}
  	self.line_name = Line.lines[self.stop_id]
  end

  def self.filter_by_line(line)
    line_name = line.split('-').map do |word|
      word.capitalize
    end.join(' ')      
    self.where(line_name: line_name).order(:stop_name)
  end

end
