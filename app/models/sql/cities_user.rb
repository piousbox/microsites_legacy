
class CitiesUser < ActiveRecord::Base

	extend AppModel

	has_many :venues
  has_many :addressbookitems
	
	belongs_to :city
	belongs_to :user
	
end
