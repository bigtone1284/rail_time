namespace :send_alerts do
	desc "send all the alerts at the appropriate time."
	task :send_alerts => :environment do
		time = Time.now.utc.strftime("%H%M")
		Alert.all.each do |alert|
			if alert.time.strftime("%H%M") == time
				AlertMailer.alert_email(alert).deliver
			end
		end
	end

	desc "send all the alerts from the last 10 minutes."
	task: :send_alerts_ten => :environment do
		time = Time.now.utc.strftime("%H%M")[0..-2]
		Alert.all.each do |alert|
			if alert.time.strftime("%H%M")[0..-2] == time
				AlertMailer.alert_email(alert).deliver
			end
		end
	end

end
