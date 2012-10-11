class VenueType < ActiveRecord::Base


	extend AppModel
  
  validates :name, :length => { :minimum => 2 }, :presence => true, :uniqueness => true
  validates :name_seo, :length => { :minimum => 2 }, :presence => true, :uniqueness => true

	has_many :venue

end
