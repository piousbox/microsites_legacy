

class Domain
  
  include Mongoid::Document
  
  field :name, :type => String
  field :subhead, :type => String
  field :about, :type => String
  
  has_many :tags
  
end