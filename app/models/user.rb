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

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  validates :name, :presence => true, :length => {:maximum => 50}
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => VALID_EMAIL}
  validates :password, :length => {:minimum => 6}
  has_secure_password

  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :reverse_relationships, :foreign_key => "followed_id", :dependent => :destroy, :class_name => "Relationship"
  has_many :following, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships, :source => :follower

  has_many :posts, :dependent => :destroy

  has_many :clicks

  before_validation :downcase_email

  def friend(followed)
   self.relationships.create(:followed_id => followed.id)
 end

   def unfriend(followed)
     self.relationships.find_by_followed_id(followed.id).destroy
   end

   def friend?(followed)
    self.relationships.find_by_followed_id(followed.id)
  end

  def friends
    self.following
  end

  def downcase_email
    self.email = self.email.downcase
  end

  def feed
    friend_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Post.where("user_id IN (#{friend_ids}) OR user_id = :user_id", user_id: self.id)
  end

  def slow_feed
    friend_ids = self.friends.pluck(:followed_id)
    friend_ids << self.id.to_s
    Post.where('user_id IN (:friend_ids)', friend_ids: friend_ids)
    Post.select {|post| friend_ids.include?(post.user_id.to_s)}
  end

end
