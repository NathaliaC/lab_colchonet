class Room < ActiveRecord::Base
	#attr_acessible :description, :location, :title
  scope :most_recent, -> {order('created_at DESC')}
  belongs_to :user
  validates_presence_of :title, :location, :description  
  validates_length_of :description, minimum: 30, allow_back: false 
  
  def complete_name
    "#{title}, #{location}"
  end
end
