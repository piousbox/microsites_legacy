class GalleriesTag < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :gallery
end
