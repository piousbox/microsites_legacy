

class Venue
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  
  belongs_to :city
  
end