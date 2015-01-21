class AlertsController < ApplicationController

	def show
		@alert = Alert.find(params[:id])
	end

	def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(alert_params)
    if @location.save
    	redirect_to @alert
    else
    	render :new
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