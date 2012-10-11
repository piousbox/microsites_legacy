

class NoReport
  
  include Mongoid::Document
  
  store_in :collection => 'reports'
  
  field :name, :type => String
  field :name_seo, :type => String
  
  field :subhead, :type => String
  
  field :descr, :type => String
  
  field :x, :type => Float
  field :y, :type => Float
  
  field :user_id, :type => Integer
  
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime
  
  field :is_public, :type => Boolean
  field :is_done, :type => Boolean
  field :is_feature, :type => Boolean
  field :is_trash, :type => Boolean
  
  field :lang, :type => String
  
  has_many :photos
  
  
end