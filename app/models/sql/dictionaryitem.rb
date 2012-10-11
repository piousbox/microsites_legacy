class Dictionaryitem < ActiveRecord::Base
  
  has_many :dictionaryitems_tags, :dependent => :destroy
  has_many :tags, :through => :dictionaryitems_tags

	def self.per_page
    4
  end
	
end
