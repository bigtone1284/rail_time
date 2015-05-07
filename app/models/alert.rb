class Alert < ActiveRecord::Base
	belongs_to :station
	validates_presence_of :email_address, :time, :station_id, :direction
	validate :email_address_validator
	before_create :add_unsubscribe_hash

	def email_address_validator
		if email_address != nil && !(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(email_address))
			errors.add(:email_address, "Not a valid Email Address.")
		end
	end

	def add_unsubscribe_hash
    self.unsubscribe_hash = SecureRandom.hex
	end
	
end
