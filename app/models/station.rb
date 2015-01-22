class Station < ActiveRecord::Base
	has_many :alerts
end