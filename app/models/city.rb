

class City
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :cityname, :type => String
  
  field :is_feature, :type => Boolean
  
  field :x, :type => Float
  field :y, :type => Float
  
  belongs_to :country
  
  has_many :reports
  has_many :galleries
  has_many :communities
  has_many :venues
  has_many :events
  
  field :calendar_frame, :type => String
  
  def self.feature
    where( :is_feature => true )
  end
  
  def self.non_feature
    where( :is_feature => false )
  end
  
end