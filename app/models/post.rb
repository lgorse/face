class Post < ActiveRecord::Base
  attr_accessible :text, :user_id

  validates :text, :presence => :true
  validates :user_id, :presence => :true

  belongs_to :user

  default_scope :order => 'created_at DESC'
end
