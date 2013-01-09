

class Site

  include Mongoid::Document
  include Mongoid::Timestamps

  field :domain, :type => String
  validates :domain, :uniqueness => true, :allow_nil => false

  field :title, :type => String

  field :subhead, :type => String

  has_many :reports
  accepts_nested_attributes_for :reports, :allow_destroy => false

  has_many :galleries
  accepts_nested_attributes_for :galleries, :allow_destroy => false

  has_many :tags
  accepts_nested_attributes_for :tags, :allow_destroy => false

  embeds_many :features
  embeds_many :newsitems
  
end