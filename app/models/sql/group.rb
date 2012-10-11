

class Group < ActiveRecord::Base

	extend AppModel
	
  has_many :users
	
  
end
