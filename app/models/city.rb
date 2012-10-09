

class City
  
  include Mongoid::Document
  
  field :name, :type => String
  field :cityname, :type => String
  
  field :is_feature, :type => Boolean
  
end