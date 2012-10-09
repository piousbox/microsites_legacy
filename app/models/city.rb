

class City
  
  include Mongoid::Document
  
  field :id, :type => Integer
  
  field :name, :type => String
  field :cityname, :type => String
  
  field :is_feature, :type => Boolean
  
  belongs_to :country
  
end