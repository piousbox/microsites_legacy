

class Community
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  
  belongs_to :city
  belongs_to :language
  
end