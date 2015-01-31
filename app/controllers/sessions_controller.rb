class SessionsController < ApplicationController

	def create
		@user = User.find_by(username: params["data"]["username"])
    if @user && @user.authenticate(params["data"]["password"])
    	session[:current_user_id] = @user.id
    	render json: @user.attributes.select{ |k, v| k != :password_digest }
    else
 			render json: @user.errors, status: 422
    end
	end

  def destroy
    session[:current_user_id] = nil
  end

end