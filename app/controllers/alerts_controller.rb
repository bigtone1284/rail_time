class AlertsController < ApplicationController

	def show
		@alert = Alert.find(params[:id])
	end

	def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(
      user_id: params["data"]["user"].to_i,
      direction: params["data"]["direction"],
      station_id: params["data"]["station"].to_i,
      time: Time.parse(params["data"]["time"])
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