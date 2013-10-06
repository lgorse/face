require 'spec_helper'

describe Post do
  

  describe "validations" do
  	before(:each) do
  		@user = FactoryGirl.create(:user)
  		@attr = {:user_id => @user.id, :text => "Hello, test"}

  	end

  	it "should have text" do
  		post = Post.new(@attr.merge(:text => ''))
  		post.should_not be_valid

  	end

  	it "should have a user" do
  		post = Post.new(@attr.merge(:user_id => ''))
  		post.should_not be_valid
  	end

    it "should be ordered by most recent" do
      old_post = Post.create(:user_id => @user.id, :text => "Boom")
      new_post = Post.create(:user_id => @user.id, :text => "Bam")
      Post.first.should == new_post


    end

  end

  describe "dependencies" do
  	before(:each) do
  		@user = FactoryGirl.create(:user)
  		@post = Post.create(:user_id => @user.id, :text => "Hello, test")
  	end

  	it "should respond to a user attribute" do
  		@post.should respond_to(:user)
  	end

  end
end
