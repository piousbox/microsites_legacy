
class CommunitiesUser < ActiveRecord::Base

	belongs_to :user
	belongs_to :community
  
  extend AppModel
	
end
