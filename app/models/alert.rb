class Alert < ActiveRecord::Base
	belongs_to :user, :station
end