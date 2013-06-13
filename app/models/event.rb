class Event
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :date, :type => DateTime
  
  belongs_to :city
  
end
