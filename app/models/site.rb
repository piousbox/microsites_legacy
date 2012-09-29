

class Site
  
  include Mongoid::Document
  
  field :name, :type => String
  field :subhead, :type => String
  field :about, :type => String
  field :domain, :type => String
  
  has_many :tags
  
end