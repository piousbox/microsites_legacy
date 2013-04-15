class Feature  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :subhead, :type => String

  field :image_path, :type => String
  field :link_path, :type => String
  field :partial_name, :type => String, :default => nil

  has_one :photo

  field :weight, :type => Integer, :default => 10
  
  belongs_to :report
  belongs_to :gallery

  embedded_in :venue
  embedded_in :site

  def self.all
    self.order_by( :created_at => :desc )
  end

  def self.n_features
    4
  end
  
end
