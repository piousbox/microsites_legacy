

class City
  
  include Mongoid::Document
  
  field :name, :type => String
  field :name_seo, :type => String
  
end