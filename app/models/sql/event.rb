
class Event < ActiveRecord::Base
  
  extend AppModel
  include Valid
  
  belongs_to :user
  belongs_to :city
  belongs_to :venue
  
  has_many :addressbookitem
  
  has_attached_file :photo,
    :styles => {
    :thumb=> "100x100#",
    :mini => '20x20#',
    :small  => "400x400>",
    :medium => '600x800>'
  },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "events/:style/:id/:filename"
  
  def self.today_in city_id
    tomorrow = DateTime.now.in_time_zone("Eastern Time (US & Canada)").tomorrow.to_date
    yesterday = DateTime.now.in_time_zone("Eastern Time (US & Canada)").yesterday.to_date
    
    find(:all, 
      :conditions => [ 'is_trash = 0 and is_public = 1 and date < ? and date > ? and city_id = ?', tomorrow, yesterday, city_id],
      :order => 'name desc'
    )
  end
  
  def to_param
    return self.name_seo unless self.name_seo.blank?
    self.id
  end
  
  
end
