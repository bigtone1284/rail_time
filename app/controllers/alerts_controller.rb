class AlertsController < ApplicationController

	def show
		@alert = Alert.find(params[:id])
	end

  def create
    @alert = Alert.new(
      email_address: params["email_address"],
      direction: params["direction"],
      station_id: params["stop"].to_i,
      time: Time.parse(params["time"]).utc
    )
    if @alert.save
      render json: @alert.attributes
    else
      render json: @alert.errors, status: 422
    end
  end

  def edit
    @alert = Alert.find(params[:id])
  end

  def update
    @alert = Alert.find(params[:id])
    redirect_to @alert
  end

  def destroy
    @alert = alert.find(params[:id])
    @alert.destroy
    render :home
  end

  private

  def alert_params
  	params.require(:alert).permit(:station_name, :direction, :time)
  end

end