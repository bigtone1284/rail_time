class Alert < ActiveRecord::Base
	belongs_to :station
	validates_uniqueness_of :email_address
	validates_presence_of :email_address
	validate :email_address_validator

	def email_address_validator
		if email_address != nil && !(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(email_address))
			errors.add(:email_address, "Not a valid Email Address.")
		end
	end
	
end