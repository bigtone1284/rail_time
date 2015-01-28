class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(
			username: params["data"]["username"],
			password: params["data"]["password"],
			password_confirmation: params["data"]["password_confirmation"],
			email_address: params["data"]["email_address"]
		)
		if @user.save
			render json: @user.attributes.select{ |k, v| k != :password_digest }
		else
			render json: @user.errors, status: 422
		end
	end

	def edit
		@user = User.find(params[:id])
		if @user != current_user
			render :home
		end
	end

	def update
		@user = User.find(params[:id])
		if @user != current_user
			render :home
		else
			if @user.update(user_params)
				redirect_to @user
			else
				render :edit
			end
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user != current_user
			redirect_to @user
		else
			@user.destroy
			session[:current_user_id] = nil
			render :home
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation, :email_address, :phone_number)
	end

end