class RelationshipsController < ApplicationController

	before_filter :authenticate

	def create
		@user = User.find(params[:relationship][:followed_id])
		@current_user.friend(@user)
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		@current_user.unfriend(@user)
	end
end
