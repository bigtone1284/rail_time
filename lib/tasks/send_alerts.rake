namespace :send_alerts do
	desc "send all the alerts at the appropriate time."
	task :send_alerts => :environment do
		time = Time.now.utc.strftime("%H%M")
		binding.pry
		Alert.all.each do |alert|
			binding.pry
			if alert.time.strftime("%H%M") == time
				binding.pry
				AlertMailer.alert_email(alert).deliver
				puts "mailer sent"
			end
		end
	end
end
