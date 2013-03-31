class Feature  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :subhead, :type => String

  # @TODO
  # deprecated, remove this.
  field :image_path, :type => String
  field :link_path, :type => String
  has_one :photo

  field :weight, :type => Integer, :default => 10
  
  belongs_to :report
  belongs_to :gallery
  belongs_to :tag

  embedded_in :venue
  embedded_in :site

  def self.all
    self.order_by( :created_at => :desc )
  end

  def self.n_features
    4
  end
  
end
