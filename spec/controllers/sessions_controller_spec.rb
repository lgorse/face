require 'spec_helper'

describe SessionsController do
	render_views


	describe 'new' do
		describe 'if there is a session' do
			before(:each) do
				@user = FactoryGirl.create(:user)
				test_sign_in(@user)
			end
			

			it 'should redirect to the corresponding user page' do
				get :new
				response.should redirect_to @user
			end

		end

		describe 'if there is no session' do
			before(:each) do
				get :new
			end

			it 'should be successful' do
				response.should be_successful
			end

			it 'should have a link to a new user' do
				response.body.should have_link("Sign up!", href: new_user_path)

			end

		end

	end

	describe 'create' do
		before(:each) do
			@user = FactoryGirl.create(:user)
		end

		describe 'if the user exists' do
			before(:each) do
				@attr = {:email => @user.email, :password => @user.password}
				post :create, :session => @attr
			end

			it 'should redirect to the user page' do
				response.should redirect_to @user
			end

			it 'should create a session with the user id' do
				session[:user_id].should == @user.id
			end

		end

		describe 'if the user is not valid' do
			before(:each) do
				bad_email = @user.email << "n"
				@attr = {:email => bad_email, :password => @user.password }
				post :create, :session => @attr

			end

			it 'should render the new session view' do
				response.should render_template 'new'

			end

			it 'should not create a session id' do
				session[:user_id].should == nil

			end

		end

	end

	describe 'destroy' do
		before(:each) do
			@user = FactoryGirl.create(:user)
			test_sign_in(@user)
			delete :destroy
		end

		it 'should redirect to the root path' do
			response.should redirect_to root_path
		end

		it 'should destroy the session' do
			session[:user_id].should be_nil

		end

	end



end
