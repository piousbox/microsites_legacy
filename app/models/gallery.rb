
class Gallery
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :tag
  belongs_to :city
  belongs_to :user
  
  field :is_feature, :type => Boolean, :default => false
  field :is_public, :type => Boolean, :default => true
  field :is_done, :type => Boolean, :default => false
  field :is_trash, :type => Boolean, :default => false
  
  field :name, :type => String
  field :galleryname, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  
  field :x, :type => Float
  field :y, :type => Float
  
  scope :fresh, where( :is_trash => false )
  scope :public, where( :is_public => true )
  scope :done, where( :is_done => true )
  
  has_many :photos
    
  def self.list conditions = { :is_trash => 0 }
		out = self.where( conditions).order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
end