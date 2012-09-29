


class NoTag
  
  store_in :collection => "tags"
  
  include Mongoid::Document
  
  field :name, :type => String
  field :name_seo, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  field :domain, :type => String
  
  field :id, :type => String
  field :user_id, :type => String
  
#  has_many :reports
#  accepts_nested_attributes_for :reports, :allow_destroy => false
#  
#  has_many :galleries
#  accepts_nested_attributes_for :galleries, :allow_destroy => false
  
  # belongs_to :parent_tag, :class_name => 'Tag', :inverse_of => :children_tags
  # has_many :children_tags, :class_name => 'Tag', :inverse_of => :parent_tag
  # accepts_nested_attributes_for :children_tags, :allow_destroy => false
  # accepts_nested_attributes_for :parent_tag, :allow_destroy => false
  
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  
  field :is_public, :type => Boolean
  field :is_feature, :type => Boolean
  field :is_trash, :type => Boolean
  
  field :lang, :type => String
  
end