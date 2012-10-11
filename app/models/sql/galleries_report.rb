

class GalleriesReport < ActiveRecord::Base
  
  belongs_to :report
  belongs_to :gallery
  
end
