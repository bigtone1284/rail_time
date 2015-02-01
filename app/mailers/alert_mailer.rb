class AlertMailer < ActionMailer::Base
  default from: ENV["GMAIL_MTA"]
  
  def alert_email(alert)
  	@alert = alert
  	mail(to @alert.email, subject: "Metro North Alerts")
  end

end
