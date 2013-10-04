require 'spec_helper'

describe SessionsController do
	render_views


	describe 'new' do
		describe 'if there is a session' do
			before(:each) do
				#@user = FactoryGirl.create(:user)
				#test_sign_in(@user)
			end
			

			it 'should redirect to the corresponding user page' do
				#get :new
				#response.should redirect_to @user

			end

		end

		describe 'if there is no session' do
			before(:each) do
				get :new
			end

			it 'should be successful' do
				response.should be_successful
			end

			it 'should have a log in form' do
				pending 'creation of user model'

			end

			it 'should have a link to a new user' do
				response.body.should have_link("Sign up!", href: new_user_path)

			end

		end

	end

	describe 'create' do

	end



end
