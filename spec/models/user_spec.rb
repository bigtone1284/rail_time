require 'rails_helper'

describe User do 

	it { is_expected.to validate_presence_of :username }

	it { is_expected.to validate_uniqueness_of :username }
	it { is_expected.to validate_uniqueness_of :email_address }
	it { is_expected.to validate_uniqueness_of :phone_number }

	let(:hari) {new_user = User.create( 
		username: "superman",
		first_name: "hari",
		last_name: "Doe",
		password: "hunter2",
		password_confirmation: "hunter2"
	)}

	let(:mck) {new_user = User.create( 
		username: "superman",
		first_name: "mck",
		last_name: "Doe",
		password: "hunter2",
		password_confirmation: "hunter2"
	)}

	it "saves a valid user" do
		expect(hari).to be_valid
	end

	it "does not allow for duplicate usernames" do
		expect(mck).to_not be_valid
	end


end