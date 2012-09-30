


class Report
  
  include Mongoid::Document
  
  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false
  
  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false
  
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
  
  before_create do |d|
    if d.name_seo.blank?
      d.name_seo = URI.escape d.name
    end
  end
  
end