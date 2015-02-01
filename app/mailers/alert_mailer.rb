class AlertMailer < ActionMailer::Base

  def alert_email(alert)
  	@alert = alert
  	@updates = MTA.station_update(@alert.station.stop_id, @alert.direction)
  	mail(to: @alert.email_address, subject: "Your Alert Updates from RailTime!")
  end

end
