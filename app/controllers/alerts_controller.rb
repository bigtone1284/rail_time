class AlertsController < ApplicationController

  def create
    @alert = Alert.new(
      email_address: params["email_address"],
      direction: params["direction"],
      station_id: params["stop"].to_i,
      time: Time.parse(params["time"]),
    )
    if @alert.save
      render json: @alert.attributes
    else
      render json: @alert.errors, status: 422
    end
  end


  def unsubscribe
    if alert = Alert.find_by_unsubscribe_hash(params[:unsubscribe_hash])
      alert.destroy
      flash[:destroy] = "Unsubscribed. Feel free to schedule a new alert!"
    else
      flash[:destroy] = "Subcription Error.  Contact Admin."
    end
    redirect_to root_path
  end

  private

  def alert_params
  	params.require(:alert).permit(:station_name, :direction, :time, :unsubscribe_hash)
  end

end