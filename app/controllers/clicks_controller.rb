class ClicksController < ApplicationController

	before_filter :authenticate

	def create
		@click = Click.create(:user_id => @current_user.id, :button_id => params[:click][:button_id])
	end

end
