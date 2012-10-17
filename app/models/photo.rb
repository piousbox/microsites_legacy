

class Photo
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  belongs_to :gallery
  belongs_to :city
  belongs_to :user, :inverse_of => :photo
  belongs_to :profile_user, :class_name => 'User', :inverse_of => :profile_photo
  belongs_to :report
  
  field :descr, :type => String
  field :is_public, :type => Boolean, :default => true
  field :is_trash, :type => Boolean, :default => false
  
  scope :fresh, where( :is_trash => false )
  
  has_mongoid_attached_file :photo, 
    :styles => {
    :mini => '20x20#',
    :thumb => "100x100#",
    :two_hundred => '200x200#',
    :small  => "400x400>",
    :small_square => "400x400#",
    :large => '950x950>',
    :large_square => '950x950#'
  },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "photos/:style/:id/:filename"

end


