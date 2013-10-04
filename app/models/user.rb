# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  password_hash :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  validates :name, :presence => true, :length => {:maximum => 50}
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => VALID_EMAIL}
  validates :password, :length => {:minimum => 6}
  has_secure_password

end
