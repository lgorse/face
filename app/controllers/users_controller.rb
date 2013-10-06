class UsersController < ApplicationController

	before_filter :authenticate, :except => [:new, :create]

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
		@user = User.find(params[:id])
		@posts = @user.feed
		@post = Post.new
	end

	def index
		@users = User.all.reject{|user| user.id == @current_user.id}

	end

	def friends
		@friends = @current_user.friends
	end
end
