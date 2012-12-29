

class Photo
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  
  belongs_to :gallery
  belongs_to :city, :inverse_of => :photos
  belongs_to :user, :inverse_of => :photos
  has_and_belongs_to_many :viewers, :class_name => 'User', :inverse_of => :viewable_photos
  belongs_to :profile_user, :class_name => 'User', :inverse_of => :profile_photo
  belongs_to :profile_city, :class_name => 'City', :inverse_of => :profile_photo
  belongs_to :report
  
  field :descr, :type => String
  field :is_public, :type => Boolean, :default => true
  field :is_trash, :type => Boolean, :default => false
  field :old_id, :type => Integer
  
  scope :fresh, where( :is_trash => false )
  
  has_mongoid_attached_file :photo, 
    :styles => {
    :mini => '20x20#',
    :thumb => "100x100#",
    :two_hundred => '200x200#',
    :small  => "400x400>",
    :small_square => "400x400#",
    :large => '950x650>',
    :large_square => '950x650'
  },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "photos/:style/:id/:filename"

  def self.n_per_manager_gallery
    25
  end
  
#  def to_jq_upload
#    {
#      "name" => read_attribute(:descr),
#      "size" => photo.size,
#      "url" => photo.url(:original),
#      "thumbnail_url" => photo.url(:thumb),
#      "delete_url" => show_photo_path(:id => _id),
#      "delete_type" => "DELETE" 
#    }
#  end
  
end


