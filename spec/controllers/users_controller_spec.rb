require 'spec_helper'

describe UsersController do

	describe 'New' do

		describe 'if the user is signed in' do
			before(:each) do
				@user = FactoryGirl.create(:user)
				test_sign_in(@user)
			end
			it "should redirect to the users home page" do
				get :new
				response.should redirect_to @user
			end
		end

		describe 'if the user is not signed in' do
			before(:each) do
				@user = FactoryGirl.create(:user)
			end

			 it 'should be successful' do
			 	get :new
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
				post :create, :user => @attr
				session[:user_id].should == assigns(:user).id
			end

			it 'should redirect to the user page' do
				post :create, :user => @attr
				response.should redirect_to user_path(assigns(:user))

			end

		end

	end

	describe 'GET show' do
		before(:each) do
			@user = FactoryGirl.create(:user)
		end

		describe 'if the user is not signed in' do

			it 'should redirect to root' do
			get :show, :id => @user.id
			response.should redirect_to root_path
		end
		end

		describe 'if the user is signed in' do
			before(:each) do
				test_sign_in(@user)
			end

			it 'should be successful' do
				get :show, :id => @user.id
				response.should be_success

			end

		end

	end

	describe 'GET index' do
		before(:each) do
			@user = FactoryGirl.create(:user)
			test_sign_in(@user)
			2.times do 
				user = FactoryGirl.create(:user)
			end
			@user_count = (User.all.count-1)
			
		end

		it "should show all the existing users" do
			get :index
			assigns(:users).count.should == @user_count

		end

		it "should not show the current user" do
			get :index
			assigns(:users).should_not include(@user)

		end

	end

	describe 'GET friends' do
		before(:each) do
			@user = FactoryGirl.create(:user)
			test_sign_in(@user)
			2.times do 
				user = FactoryGirl.create(:user)
				@user.friend(user)
			end
			@user2 = FactoryGirl.create(:user)
			get :friends, :id => @user.id
		end

		it "should show the user's friends" do
			assigns(:friends).should == @user.friends

		end

		it "should not show existing users who are not friends" do
			assigns(:friends).should_not include(@user2)

		end

	end


end
