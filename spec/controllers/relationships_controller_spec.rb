require 'spec_helper'

describe RelationshipsController do

	describe "POST create" do
		before(:each) do
			@user1 = FactoryGirl.create(:user)
			@user2 = FactoryGirl.create(:user)
			@attr = {:followed_id => @user2.id}
			test_sign_in(@user1)
		end

		it "should create a new relationship" do
			lambda do
				post :create, :relationship => @attr
			end.should change(Relationship, :count).by(1)

		end
	end

	describe "DELETE destroy" do
		before(:each) do
			@user1 = FactoryGirl.create(:user)
			@user2 = FactoryGirl.create(:user)
			@attr = {:followed_id => @user2.id}
			test_sign_in(@user1)
			@user1.friend(@user2)
			@relationship = @user1.relationships.find_by_followed_id(@user2)
		end

		it "should remove the relationship" do
			lambda do
				delete :destroy, :id => @relationship
			end.should change(Relationship, :count).by(-1)

		end

	end

end
