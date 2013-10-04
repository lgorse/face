class SessionsController < ApplicationController

def new
	
end

def create
	@user = User.find_by_email(params[:session][:email])
	if @user && @user.authenticate(params[:session][:password])
		redirect_to @user
	else
		flash.now.alert = "Invalid email or password"
		render 'new'
	end

end

end
