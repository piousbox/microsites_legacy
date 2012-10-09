

class Country
  
  include Mongoid::Document
  
  field :name, :type => String
  field :countryname, :type => String
  
  has_many :cities
  
end