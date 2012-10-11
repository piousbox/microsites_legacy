
class Tag < ActiveRecord::Base

	extend AppModel
  
  # has_many :statuses

  has_many :tags_videos, :dependent => :destroy
  has_many :videos, :through => :tags_videos
  
  has_many :tags_venues, :dependent => :destroy
  has_many :venues, :through => :tags_venues
  
  has_many :galleries_tags, :dependent => :destroy
  has_many :galleries, :through => :galleries_tags
  
  has_many :dictionaryitems_tags, :dependent => :destroy
  has_many :dictionaryitems, :through => :dictionaryitems_tags
  
  has_many :addressbookitems_tags, :dependent => :destroy
  has_many :addressbookitems, :through => :addressbookitems_tags
  
  has_many :reports_tags, :dependent => :destroy
  has_many :reports, :through => :reports_tags, :limit => Report.per_tag_page
  
  belongs_to :photo
  
  has_many :tags, :foreign_key => :parent_id
  
  has_many :recent_reports, :through => :reports_tags,
    :source => :report,
    :conditions => ['is_trash = 0 and is_public = 1'],
    :order => 'created_at desc', 
    :limit => 10
  
  has_many :feature_reports, :through => :reports_tags, 
    :source => :report, 
    :conditions => ['reports.is_feature = ? and reports.is_trash = ? and reports.is_public = ?', 1, 0, 1],
    :order => 'created_at asc',
    :limit => 4
  
  belongs_to :user
  
  validates_uniqueness_of :name
  
  def self.per_page
    10
  end
  
  def self.n_features
    4
  end
  
  has_many :descendants, :class_name => 'Tag', :foreign_key => :parent_id
  
  def self.index_small
    
    find:all,
      :conditions => { :is_trash => 0, :is_public => 1 },
      :order => 'name asc'
    
  end
  
  def n_reports
    reports.length
  end
  
  def n_galleries
    galleries.length
  end
  
  def self.features args = {}
    args[:n] ||= 4
    args[:parsed_locale] ||= 'en'
    
    find :all,
      :conditions => { :is_feature => 1, :is_trash => 0, :is_public => 1, :lang => args[:parsed_locale] },
      :order => 'name asc',
      :include => [ :feature_reports ],
      :limit => args[:n]
    
  end
  
end
