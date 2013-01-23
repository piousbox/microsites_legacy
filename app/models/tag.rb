
class Tag

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false

  field :descr, :type => String
  field :subhead, :type => String
  field :domain, :type => String

  field :is_trash, :type => Boolean, :default => false
  scope :fresh, where( :is_trash => false )
  scope :trash, where( :is_trash => true )

  field :is_public, :type => Boolean, :default => true
  scope :public, where( :is_public => true )
  scope :not_public, where( :is_public => false )

  field :is_feature, :type => Boolean, :default => false

  field :x, :type => Float
  field :y, :type => Float
  field :lang, :type => String, :default => 'en'
  
  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false

  has_one :photo
  
  has_many :reports
  has_many :galleries
  has_many :videos
  has_many :children_tags, :class_name => 'Tag', :inverse_of => :parent_tag

  belongs_to :parent_tag, :class_name => 'Tag', :inverse_of => :children_tags
  belongs_to :user

  before_create do |d|
    if d.name_seo.blank?
      d.name_seo = URI.escape d.name
    end
    
    if '' == d.domain
      d.domain = nil
    end
  end

  def self.clear
    if Rails.env.test?
      Tag.all.each { |r| r.remove }
    end
  end
  
  before_update do |d|
    if '' == d.domain
      d.domain = nil
    end
  end
  
  def self.no_parent
    Tag.where( :parent_tag_id => nil )
  end
  
  def self.no_domain
    Tag.where( :domain.exists => false )
  end
  
  def self.features n = 4
    Tag.where( :is_feature => true ).limit(n)
  end
  
  def self.list
		out = self.order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
end