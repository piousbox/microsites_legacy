class Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include AuxModel

  field :domain, :type => String
  field :lang, :type => String, :default => 'en'
  
  field :title, :type => String
  field :subhead, :type => String

  field :n_features, :type => Integer, :default => 4
  field :n_newsitems, :type => Integer, :default => 20
  field :is_video_enabled, :type => Boolean, :default => false
  field :is_resume_enabled, :type => Boolean, :default => false
  field :is_ads_enabled, :type => Boolean, :default => true

  has_many :reports
  has_many :galleries
  has_many :tags
  has_many :videos

  embeds_many :features
  embeds_many :newsitems

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

  LANGUAGES = [ 'en', 'ru', 'pt' ]

  def self.list conditions = { :is_trash => false }
    out = self.where( conditions).order_by( :domain => :asc )
    [['', nil]] + out.map { |item| [ "#{item.domain} #{item.lang}", item.id ] }
  end
  
end
