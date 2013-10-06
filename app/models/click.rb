class Click < ActiveRecord::Base
  attr_accessible :button_id, :user_id

  validates :button_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :user

  def button
  	case self.button_id
  	when MAGIC
  		"Magic"
  	end

  end
end
