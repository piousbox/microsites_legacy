

class Tag
  
  include Mongoid::Document
  
  field :name, :type => String
  field :subhead, :type => String
  field :domain, :type => String
  
  has_many :reports
  accepts_nested_attributes_for :reports, :allow_destroy => false
  
  has_many :galleries
  accepts_nested_attributes_for :galleries, :allow_destroy => false
  
end