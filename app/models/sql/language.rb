
class Language < ActiveRecord::Base

  extend AppModel
  
	has_many :community
	
end
