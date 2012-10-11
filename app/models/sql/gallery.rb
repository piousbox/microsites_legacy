class Gallery < ActiveRecord::Base
  
  extend AppModel
  include Valid
  
  belongs_to :user
  belongs_to :city
  
  has_many :photos, :conditions => { :is_trash => 0 }
  
  has_many :galleries_reports
  has_many :reports, :through => :galleries_reports
  
  has_many :galleries_tags, :dependent => :destroy
  has_many :tags, :through => :galleries_tags
  
  def self.n_features
    4
  end
  
  def self.per_page
    8
  end
  
  def photo
    photos[0]
  end
  
end
