require 'string'
class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name_en, :type => String, :default => ''
  field :name_pt, :type => String, :default => ''
  field :name_ru, :type => String, :default => ''

  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false
  
  field :subhead, :type => String
  field :descr, :type => String

  field :is_trash, :type => Boolean, :default => false
  
  field :is_public, :type => Boolean, :default => true
  scope :public, where( :is_public => true )

  field :is_feature, :type => Boolean, :default => false

  field :x, :type => Float
  field :y, :type => Float
  field :lang, :type => String, :default => 'en'
  
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
      if !d.name_en.blank?
        d.name_seo = d.name_en.to_simple_string
      else
        d.name_seo = d.name.to_simple_string + " #{rand(1000)}"
      end
    end
    
  end

  def self.clear
    if Rails.env.test?
      Tag.each { |r| r.remove }
    end
  end
  
  def self.no_parent
    Tag.where( :parent_tag_id => nil )
  end
  
  def self.features n = 4
    self.all.where( :is_feature => true ).limit( n )
  end

  # how many reports per tag in tags/index?
  # how many galleries per tag in tags/index?
  def self.n_items
    10
  end
  
  def self.list args = { :conditions => { :is_public => true, :is_trash => false }, :lang => :en }
		out = Tag.where( args[:conditions] ).order_by( :name_en => :asc )
		[['', nil]] + out.map { |item| [ item['name_'+args[:lang].to_s], item.id ] }
	end

  def self.all
    self.where( :is_public => true, :is_trash => false ).order_by( :created_at => :desc )
  end

  def name locale = 'en'
    return self[('name_'+locale).to_s]
  end

end
