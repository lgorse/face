# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Relationship do
  
  describe "validations" do
  	before(:each) do
  		@attr = {:follower_id => 1, :followed_id => 2}
  	end

  	it "should have a follower id" do
  		relationship = Relationship.new(@attr.merge(:follower_id => ''))
  		relationship.should_not be_valid
  	end

  	it "should have a followed id" do
  		relationship = Relationship.new(@attr.merge(:followed_id => ''))
  		relationship.should_not be_valid
  	end

    it "should be unique" do
      relationship = Relationship.create(@attr)
      relationship2 = Relationship.new(@attr)
      relationship2.should_not be_valid

    end

  end

  describe "dependencies" do
  	before(:each) do
  		user1 = FactoryGirl.create(:user)
  		user2 = FactoryGirl.create(:user)
  		@relationship = Relationship.create(:follower_id => user1.id, :followed_id => user2.id)
  	end

  	it "should respond to a follower attribute" do
  		@relationship.should respond_to(:follower)

  	end

  	it "should respond to a followed attribute" do
  		@relationship.should respond_to(:followed)
  	end

    it "should respond to a reverse attribute" do
      @relationship.should respond_to(:reverse)

    end

  end

  describe "should create/destroy two-way relationship" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @relationship = Relationship.create(:follower_id => @user1.id, 
                                          :followed_id => @user2.id)
      @relationship2 = Relationship.find_by_follower_id_and_followed_id(@user2.id, @user1.id)
    end

    it "should create the opposite relationship" do
      @relationship2.should be_present
    end

    it "should destroy the opposite relationship" do
      @relationship.destroy
      @relationship.reverse.should be_nil

    end

  end
end
