class SessionsController < ApplicationController

	def new
			redirect_to User.find(session[:user_id]) if signed_in
	end

	def create
		@user = User.find_by_email(params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			sign_in_user(@user)
			redirect_to @user
		else
			flash.now.alert = "Invalid email or password"
			render 'new'
		end

	end

	def destroy
		sign_out_user
	end

end
