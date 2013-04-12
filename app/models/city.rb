class City  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  field :cityname, :type => String
  validates :cityname, :uniqueness => true, :allow_nil => false
  
  field :name_en, :type => String, :default => ''
  validates :name_en, :uniqueness => true, :allow_nil => false, :presence => true

  field :name_ru, :type => String, :default => ''
  validates :name_ru, :uniqueness => true, :allow_nil => false, :presence => true

  field :name_pt, :type => String, :default => ''
  validates :name_pt, :uniqueness => true, :allow_nil => false, :presence => true
  
  field :is_feature, :type => Boolean, :default => false
  
  field :x, :type => Float
  field :y, :type => Float
  
  belongs_to :country
  
  has_many :cities_users
  
  has_many :reports
  has_many :galleries
  has_many :communities
  has_many :venues
  has_many :events
  has_many :photos

  has_one :profile_photo, :class_name => 'Photo', :inverse_of => :profile_city
  has_one :guide, :class_name => 'User', :inverse_of => :guide_city
  has_many :current_users, :class_name => 'User', :inverse_of => :current_city

  embeds_many :newsitems
  field :n_newsitems, :type => Integer, :default => 16

  embeds_many :features
  field :n_features, :type => Integer, :default => 4

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

  def self.list_citynames lang = 'en'
    out = self.order_by( :name => :asc )
    [['', nil]] + out.map { |item| [ item['name_'+lang], item.cityname ] }
  end

  def self.clear
    if Rails.env.test?
      City.all.each { |r| r.remove }
    end
  end

  def self.n_features
    4
  end

end

