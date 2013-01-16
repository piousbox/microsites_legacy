
class Site

  include Mongoid::Document
  include Mongoid::Timestamps

  field :domain, :type => String

  field :title, :type => String

  field :subhead, :type => String

  has_many :reports
  # accepts_nested_attributes_for :reports, :allow_destroy => false

  has_many :galleries
  # accepts_nested_attributes_for :galleries, :allow_destroy => false

  has_many :tags
  # accepts_nested_attributes_for :tags, :allow_destroy => false

  embeds_many :features
  # accepts_nested_attributes_for :features, :allow_destroy => false

  embeds_many :newsitems
  # accepts_nested_attributes_for :newsitems, :allow_destroy => false

  field :lang, :type => String, :default => 'en'

#  set_callback :create, :before do |doc|
#    if Site.where( :lang => doc.lang, :domain => doc.domain ).length > 0
#      return false
#    end
#  end
#
#  set_callback :update, :before do |doc|
#    if Site.where( :lang => doc.lang, :domain => doc.domain ).length > 0
#      return false
#    end
#  end
  
end
