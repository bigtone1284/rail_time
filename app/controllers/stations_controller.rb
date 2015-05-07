class StationsController < ApplicationController

	def filter_by_line
		stations_on_line = Station.filter_by_line(params[:line])
		render json: stations_on_line
	end

	def updates
		station_updates = MTA.station_update(params[:id], params[:direction])
		render json: station_updates
	end

end
