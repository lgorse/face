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

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, :follower_id

  validates :followed_id, :presence => true
  validates :follower_id, :presence => true
  validates_uniqueness_of :follower_id, :scope => :followed_id
 
  belongs_to :follower, :foreign_key => "follower_id", :class_name => "User"
  belongs_to :followed, :foreign_key => "followed_id", :class_name => "User"

  after_save :create_reverse
  after_destroy :destroy_reverse

  def reverse
  	Relationship.find_by_follower_id_and_followed_id(self.followed_id, self.follower_id)
  end


  def create_reverse
  	Relationship.create(:follower_id => self.followed_id, :followed_id => self.follower_id)
  end

  def destroy_reverse
  	self.reverse.destroy if self.reverse
  end
  
end
