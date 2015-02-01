class AlertMailer < ActionMailer::Base
  default from: ENV["GMAIL_MTA"]
  
  def alert_email(user)
  	@user = user
  	mail(to @user.email, subject: "Metro North Alerts")
  end

end
