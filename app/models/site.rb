class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  field :domain, :type => String
  field :lang, :type => String, :default => 'en'
  
  field :title, :type => String
  field :subhead, :type => String

  field :n_features, :type => Integer, :default => 4
  field :n_newsitems, :type => Integer, :default => 20

  has_many :reports
  has_many :galleries
  has_many :tags

  embeds_many :features
  embeds_many :newsitems

  field :is_trash, :type => Boolean, :default => false

  set_callback :create, :before do |doc|
    if Site.where( :lang => doc.lang, :domain => doc.domain ).length > 0
      return false
    end
  end

  set_callback :update, :before do |doc|
    possible_duplicate = Site.where( :lang => doc.lang, :domain => doc.domain ).first
    if possible_duplicate.blank?
      return true
    elsif doc.id != possible_duplicate.id
      return false
    end
  end

  def self.languages
    [ 'en', 'ru', 'pt' ]
  end
  
end
