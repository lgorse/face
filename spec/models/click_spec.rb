require 'spec_helper'

describe Click do
  
  describe "validations" do
  	before(:each) do
  		@attr = {:user_id => 1, :button_id => 2}
  	end

  	it "must have a user id" do
  		click = Click.new(@attr.merge(:user_id => ''))
  		click.should_not be_valid
  	end

  	it "must have a button id" do
  		click = Click.new(@attr.merge(:button_id => ''))
  		click.should_not be_valid
  	end

  end

  describe "attributes" do
  	before(:each) do
  		@user = FactoryGirl.create(:user)
  		@click = Click.create(:user_id => @user.id, :button_id => 1 )
  	end

  	it "should have a user attribute" do
  		@click.should respond_to(:user)
  	end

  	it "should have a button method" do
  		@click.should respond_to(:button)

  	end
  end

  describe "button method" do
  	before(:each) do
  		@user = FactoryGirl.create(:user)
  		@click = Click.create(:user_id => @user.id, :button_id => MAGIC )
  	end

  	it "should return a string" do
  		@click.button.class.should == String
  	end

  end

end
