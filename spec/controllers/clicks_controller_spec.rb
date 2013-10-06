require 'spec_helper'

describe ClicksController do

	describe "POST create" do

		describe "if successful" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				@attr = {:user_id => @user.id, :button_id => 1}
				test_sign_in(@user)
			end

			it "should create a new click" do
				lambda do
					post :create, :click => @attr
				end.should change(Click, :count).by(1)
			end

		end

	end

end
