
class Site

  include Mongoid::Document
  include Mongoid::Timestamps

  field :domain, :type => String
  field :lang, :type => String, :default => 'en'
  field :title, :type => String
  field :subhead, :type => String

  has_many :reports
  has_many :galleries
  has_many :tags

  embeds_many :features
  embeds_many :newsitems

#  set_callback :save, :before do |doc|
#    if Site.where( :lang => doc.lang, :domain => doc.domain ).length > 0
#      return false
#    end
#  end
  
end
