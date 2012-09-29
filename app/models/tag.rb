

class Tag
  
  include Mongoid::Document
  
  field :name, :type => String
  field :name_seo, :type => String
  field :subhead, :type => String
  field :domain, :type => String
  
  has_many :reports
  accepts_nested_attributes_for :reports, :allow_destroy => false
  
  has_many :galleries
  accepts_nested_attributes_for :galleries, :allow_destroy => false
  
  belongs_to :parent_tag, :class_name => 'Tag', :inverse_of => :children_tags
  has_many :children_tags, :class_name => 'Tag', :inverse_of => :parent_tag
  accepts_nested_attributes_for :children_tags, :allow_destroy => false
  accepts_nested_attributes_for :parent_tag, :allow_destroy => false
  
end