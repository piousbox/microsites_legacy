
class Article
  include Mongoid::Document
  
  store_in :collection => 'reports'

  field :name, :type => String
  field :name_seo, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  
end
