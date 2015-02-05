namespace :send_alerts do
	desc "send all the alerts at the appropriate time."
	task :send_alerts => :environment do
		time = Time.now.utc.strftime("%H%M")
		Alert.all.each do |alert|
			if alert.time.strftime("%H%M") == time
				AlertMailer.alert_email(alert).deliver
				puts "mailer sent"
			end
		end
	end
end
