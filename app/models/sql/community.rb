class Community < ActiveRecord::Base

	belongs_to :city
	belongs_to :language
	belongs_to :user
  
  extend AppModel

	has_many :communities_users, :dependent => :destroy
	has_many :members, :through => :communities_users, :source => :user
  
  validates_uniqueness_of :name_seo
  validates_uniqueness_of :name
  
  has_attached_file :photo,
    :styles => {
    :thumb=> "100x100#",
    :mini => '20x20#',
    :small  => "400x400>",
    :medium => '600x800>'
  },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "communities/:style/:id/:filename"
  
  def self.find_in_city city_id
    find(:all, 
      :conditions => { :is_trash => 0, :is_public => 1, :city_id => city_id },
      :order => { :name => :asc}
    )
  end
end
