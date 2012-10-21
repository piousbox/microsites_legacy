
class Gallery
  
  include Mongoid::Document
  include Mongoid::Timestamps
  extend AppModel
  
  belongs_to :tag
  belongs_to :city
  belongs_to :user
  
  field :is_feature, :type => Boolean, :default => false
  field :is_public, :type => Boolean, :default => true
  field :is_trash, :type => Boolean, :default => false
  
  field :name, :type => String
  field :galleryname, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  
  field :x, :type => Float
  field :y, :type => Float
  
  scope :fresh, where( :is_trash => false )
  
  has_many :photos
    
  def self.list conditions = { :is_trash => 0 }
		out = self.where( conditions).order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
end