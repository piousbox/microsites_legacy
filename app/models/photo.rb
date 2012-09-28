

class Photo
  
  include Mongoid::Document
  
  belongs_to :gallery
  
end