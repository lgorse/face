class PostsController < ApplicationController

	before_filter :authenticate

	def create
		post = Post.create(:user_id => @current_user.id, :text => params[:post][:text])
	end

	def destroy
		Post.find(params[:id]).destroy
	end
end
