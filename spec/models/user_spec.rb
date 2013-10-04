# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
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



end
