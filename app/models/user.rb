class User < ActiveRecord::Base
	has_many :alerts
end