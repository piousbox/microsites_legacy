
class Gallery
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :tag
  belongs_to :city
  
  field :name, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  
  has_many :photos
  
end