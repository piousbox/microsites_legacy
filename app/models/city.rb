

class City
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false
  
  field :cityname, :type => String
  validates :cityname, :uniqueness => true, :allow_nil => false
  
  field :is_feature, :type => Boolean
  
  field :x, :type => Float
  field :y, :type => Float
  
  field :community, :type => String
  
  belongs_to :country
  
  has_many :reports
  has_many :galleries
  has_many :communities
  has_many :venues
  has_many :events
  has_many :photos
  
  field :calendar_frame, :type => String
  
  def self.feature
    where( :is_feature => true )
  end
  
  def self.non_feature
    where( :is_feature => false )
  end
  
  def self.list
		out = self.order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
end