class AlertsController < ApplicationController

  def create
    @alert = Alert.new(
      email_address: params["email_address"],
      direction: params["direction"],
      station_id: params["stop"].to_i,
      time: Time.parse(params["time"]).in_time_zone("Eastern Time (US & Canada)")
    )
    if @alert.save
      render json: @alert.attributes
    else
      render json: @alert.errors, status: 422
    end
  end

  def destroy
    @alert = alert.find(params[:id])
    @alert.destroy
    flash[:destroy] = "Alert successfully destroyed.  Feel free to schedule a new alert!"
    render :home
  end

  private

  def alert_params
  	params.require(:alert).permit(:station_name, :direction, :time)
  end

end