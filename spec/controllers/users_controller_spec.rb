require 'spec_helper'

describe UsersController do

	describe 'New' do

		describe 'if the user is signed in' do
			it "should redirect to the users home page" do
				pending "implementation of session"
			end
		end

		describe 'if the user is not signed in' do
			before(:each) do
				get :new
			end
			 it 'should be successful' do
			 	response.should be_successful
			 end

		end
	end

	describe 'POST create' do
		before(:each) do
			@attr = {:name => "tester", :email => "test@tester.com", :password => "testpass"}

		end

		describe 'if failed' do

			it "should render the new page" do
				post :create, :user => @attr.merge(:name => '')
				response.should render_template('new')

			end

			it 'should show the error' do
				post :create, :user => @attr.merge(:name => '')

			end

			it 'should not create a new user' do
				lambda do
					post :create, :user => @attr.merge(:name => '')
				end.should_not change(User,  :count)

			end
		end

		describe 'if successful' do

			it 'should create a new user' do
				lambda do
					post :create, :user => @attr
				end.should change(User, :count).by(1)

			end

			it 'should create a session' do
				pending 'creation of session'
			end

			it 'should redirect to the user page' do
				post :create, :user => @attr
				response.should redirect_to user_path(assigns(:user))

			end

		end

	end

end
