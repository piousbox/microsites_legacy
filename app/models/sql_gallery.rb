

class SqlGallery < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :city
  
  self.table_name = 'galleries'
  
  has_many :photos, :class_name => 'SqlPhotos', :conditions => { :is_trash => 0 }
  
  has_many :galleries_reports
  has_many :reports, :through => :galleries_reports
  
  has_many :galleries_tags, :dependent => :destroy
  has_many :tags, :through => :galleries_tags
  
end


