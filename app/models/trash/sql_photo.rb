

class SqlPhoto < ActiveRecord::Base
  
  self.table_name = 'photos'
  
  belongs_to :gallery, :class_name => 'SqlGallery'
  belongs_to :city, :class_name => 'SqlCity'
  
  has_attached_file :photo,
    :styles => {
    :mini => '20x20#',
    :thumb=> "100x100#",
    :small  => "400x400>",
    :small_square => "400x400#",
    :large => '950x950>',
    :large_square => '950x950#'
  },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS, # Rails.root.join('config', 's3.yml'),
    :path => "photos/:style/:id/:filename"
   
end

