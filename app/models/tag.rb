class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false
  
  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false
  
  field :is_feature, :type => Boolean, :default => false
  
  has_many :reports
  has_many :galleries
  has_many :videos

  has_many :children_tags, :class_name => 'Tag', :inverse_of => :parent_tag
  belongs_to :parent_tag, :class_name => 'Tag', :inverse_of => :children_tags

  embeds_many :features
  embeds_many :newsitems

  belongs_to :site

  before_create do |d|
    if d.name_seo.blank?
      d.name_seo = d.name.to_simple_string
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
  
  # @deprecated, there will be no reports or galleries in tags. There will be only features and newsitems
  # how many reports per tag in tags/index?
  # how many galleries per tag in tags/index?
  def self.n_items
    10
  end
  
  def self.list
    out = Tag.all.order_by( :name => :desc )
    [['', nil]] + out.map { |item| [ item.name, item.id ] }
  end

  # @deprecated I don't even know why I have this. Should be simplified into non-being.
  def self.n_features
    4
  end

end
