


class Report
  
  include Mongoid::Document
  
  field :name, :type => String
  field :name_seo, :type => String
  
  field :subhead, :type => String
  
  field :descr, :type => String
  
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  
  field :is_public, :type => Boolean, :default => true
  field :is_feature, :type => Boolean, :default => false
  field :is_trash, :type => Boolean, :default => false
  
  field :lang, :type => String
  
  belongs_to :tag
  accepts_nested_attributes_for :tag, :allow_destroy => false
  
end