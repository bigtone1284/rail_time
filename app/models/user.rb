class User < ActiveRecord::Base
	has_many :alerts
	has_secure_password
	validates_uniqueness_of :username,:email_address, :phone_number
	validates_presence_of :username
	validate :email_address_validator, :phone_number_validator

	def email_address_validator
		if email_address != nil && !(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(email_address))
			errors.add(:email_address, "Not a valid Email Address.")
		end
	end

	def phone_number_validator
		if phone_number != nil && !(/^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/).match(phone_number)
			errors.add(:phone_number, "Not a valid US phone number.")
		end
	end

end