
class Feature
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :subhead, :type => String
  field :link_path, :type => String
  field :image_path, :type => String
  
  field :is_partial, :type => Boolean, :default => false

  field :lang, :type => String, :default => 'en'
  field :weight, :type => Integer, :default => 10
  
  has_one :photo
  
  #  belongs_to :photo
  #  belongs_to :report
  #  belongs_to :gallery

  embedded_in :venue
  embedded_in :site

  def self.n_features
    4
  end

  def self.all
    Feature.order_by( :weight => :desc, :created_at => :desc )
  end

end
