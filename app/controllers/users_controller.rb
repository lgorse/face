class UsersController < ApplicationController

	before_filter :authenticate, :only => [:show]

	def new
		if signed_in
			redirect_to User.find(session[:user_id])
		else
			@user = User.new
		end
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in_user(@user)
			flash[:success] = "Welcome to #{APP_NAME}!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def show

	end
end
