
class SqlCity < ActiveRecord::Base

	extend AppModel
  include Valid
  
  self.table_name = 'cities'
  
	has_many :reports
  has_many :users
	has_many :venues
	has_many :addressbookitems
	has_many :events
	has_many :communities
	has_many :photos
	has_many :cities_users
  has_many :videos

	def self.n_features
    4
  end
  
#  has_attached_file :profile_photo,
#    :styles => {
#    :thumb=> "100x100#",
#    :small  => "400x400>" },
#    :storage => :s3,
#    :s3_credentials => S3_CREDENTIALS,
#    :path => "cities/:style/:id/:filename"
  
end
