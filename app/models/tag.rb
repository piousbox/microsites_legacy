

class Tag
  
  include Mongoid::Document
  
  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false
  
  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false
  
  field :subhead, :type => String
  
  field :descr, :type => String
  
  field :domain, :type => String
  validates :domain, :uniqueness => true, :allow_nil => true
  
  has_many :reports
  accepts_nested_attributes_for :reports, :allow_destroy => false
  
  has_many :galleries
  accepts_nested_attributes_for :galleries, :allow_destroy => false

  belongs_to :parent_tag, :class_name => 'Tag', :inverse_of => :children_tags
  accepts_nested_attributes_for :parent_tag, :allow_destroy => false
  
  has_many :children_tags, :class_name => 'Tag', :inverse_of => :parent_tag
  accepts_nested_attributes_for :children_tags, :allow_destroy => false
  
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  
  field :is_public, :type => Boolean
  field :is_feature, :type => Boolean
  field :is_trash, :type => Boolean
  
  # obsolete
  field :id, :type => String
  field :user_id, :type => String
  
  before_create do |d|
    if d.name_seo.blank?
      d.name_seo = URI.escape d.name
    end
  end
  
  def self.no_parent
    Tag.where( :parent_tag_id => nil )
  end
  
  def self.no_domain
    Tag.where( :domain.exists => false )
  end
  
end