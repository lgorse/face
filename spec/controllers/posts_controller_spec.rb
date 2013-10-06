require 'spec_helper'

describe PostsController do

	describe "POST Create" do

		describe "if successful" do
			before(:each) do
				@user = FactoryGirl.create(:user)
				test_sign_in(@user)
				@attr = {:text => "Hello, test"}
			end

			it "should create a new post" do
				lambda do
				post :create, :post => @attr
			end.should change(Post, :count).by(1)

			end

		end

	end
 
	describe "DELETE Destroy" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			test_sign_in(@user)
			@post = Post.create(:user_id => @user.id, :text => "Hello, test")
		end

		it "should destroy the post" do
			lambda do
				delete :destroy, :id => @post.id
			end.should change(Post, :count).by(-1)

		end

	end

end
