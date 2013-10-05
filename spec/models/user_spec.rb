# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe User do

	describe "validations" do
		before(:each) do
			@attr = {:name => "tester", :email => "tester@test.com", :password =>"testpass"}

		end

		describe "name" do

			it "should require a first name" do
				user = User.new(@attr.merge(:name => ''))
				user.should_not be_valid
			end

			it 'have a maximum size for the name' do
				user = User.new(@attr.merge(:name => 'a'*55))
				user.should_not be_valid
			end
		end

		describe "email" do

			it "should require an email" do
				user = User.new(@attr.merge(:email => ''))
				user.should_not be_valid
			end

			it "should be well-formed" do
				bad_emails = ['test', 'test.com', 'test@']
				bad_emails.each do |email|
					user = User.new(@attr.merge(:email => email))
					user.should_not be_valid
				end
			end

			it 'should be unique' do
				user = User.create(@attr)
				user = User.new(@attr)
				user.should_not be_valid
			end

			it "should be downcased" do
				upcase_email = "TEST@TESTER.com"
				user = User.new(@attr.merge(:email => upcase_email))
				user.save
				user.email.should == upcase_email.downcase

			end


		end

		describe 'password' do

			it "should require a password" do
				user = User.new(@attr.merge(:password => ''))
				user.should_not be_valid
			end

			it 'should have a minimum length' do
				user = User.new(@attr.merge(:password => 'nice'))
				user.should_not be_valid
			end


		end


	end

	describe "dependencies" do
		before(:each) do
			@user = FactoryGirl.create(:user)
		end

		it "should respond to a followers attribute" do
			@user.should respond_to(:followers)

		end

		it "should respond to a following attribute" do
			@user.should respond_to(:following)

		end

		it "should respond to a follow method" do
			@user.should respond_to(:follow)

		end

		it "should respond to an unfollow method" do
			@user.should respond_to(:unfollow)
		end

		it "should destroy the relationship if the user is destroyed" do
			user2 = FactoryGirl.create(:user)
			@user.follow(user2)
			@user.destroy
			Relationship.where(:follower_id => @user.id, :followed_id => user2.id).should_not exist
		end

	end

	describe "follow" do
		before(:each) do
			@user1 = FactoryGirl.create(:user)
			@user2 = FactoryGirl.create(:user)
		end

		it "should add a relationship when invoked" do
			lambda do
				@user1.follow(@user2)
			end.should change(Relationship, :count).by(1)
		end

		it "should add the new followed user to the following list" do
			lambda do
				@user1.follow(@user2)
			end.should change(@user1.following, :count).by(1)
		end

	end

	describe "unfollow" do
		before(:each) do
			@user1 = FactoryGirl.create(:user)
			@user2 = FactoryGirl.create(:user)
			@user1.follow(@user2)
		end


		it "should remove the followed from the follower's following list" do
			lambda do
			@user1.unfollow(@user2)
		end.should change(@user1.following, :count).by(-1)

		end

		it "should destroy the relationship" do
			@user1.unfollow(@user2)
			Relationship.where(:follower_id => @user1.id, :followed_id => @user2.id).should_not exist

		end

	end



end
