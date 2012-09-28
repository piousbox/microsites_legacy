

class Tag
  
  include Mongoid::Document
  
  field :name, :type => String
  field :subhead, :type => String
  field :domain, :type => String
  
end