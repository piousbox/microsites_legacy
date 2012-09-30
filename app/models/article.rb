

class Article
  
  include Mongoid::Document
  
  store_in :collection => "reports"
  
  field :name, :type => String
  
  
end