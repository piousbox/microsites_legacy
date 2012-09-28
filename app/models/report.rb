

class Report
  
  include Mongoid::Document
  
  field :name, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  
  belongs_to :tag
  
end