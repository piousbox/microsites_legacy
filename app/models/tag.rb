
class Tag

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false

  field :subhead, :type => String
  field :descr, :type => String

  # @TODO
  # deprecated, remove this
  field :domain, :type => String

  field :is_trash, :type => Boolean, :default => false
  field :is_public, :type => Boolean, :default => true
  field :is_feature, :type => Boolean, :default => false

  field :x, :type => Float
  field :y, :type => Float
  field :lang, :type => String, :default => 'en'
  
  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false

  has_one :photo

  field :weight, :type => Integer, :default => 10
  
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
      Tag.each { |r| r.remove }
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
    self.all.where( :is_feature => true ).limit( n )
  end

  # how many reports per tag in tags/index?
  # how many galleries per tag in tags/index?
  def self.n_items
    10
  end
  
  def self.list
		out = self.order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end

  def self.all
    self.where( :is_public => true, :is_trash => false ).order_by( :created_at => :desc )
  end
  
end