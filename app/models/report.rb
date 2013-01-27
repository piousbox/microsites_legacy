
class Report 
  
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String

  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :presence => true

  field :descr, :type => String

  field :is_trash, :type => Boolean, :default => false
  scope :fresh, where( :is_trash => false )
  scope :trash, where( :is_trash => true )

  field :is_public, :type => Boolean, :default => true
  scope :public, where( :is_public => true )
  scope :not_public, where( :is_public => false )

  field :is_feature, :type => Boolean, :default => false

  field :x, :type => Float
  field :y, :type => Float

  field :lang, :type => String, :default => 'en'
  
  field :username, :type => String, :default => 'anonymous'
  validates :username, :presence => true, :allow_nil => false
  belongs_to :user
  validates :user, :presence => true, :allow_nil => false

  field :subhead, :type => String

  field :is_done, :type => Boolean, :default => true
  scope :dones, where( :is_done => true )
  scope :undones, where( :is_done => false )
  
  belongs_to :tag

  belongs_to :city

  belongs_to :venue
  
  belongs_to :cities_user
  
  has_one :photo

  field :n_upvotes, :default => 0
  field :n_spamvotes, :default => 0
  
  def self.list conditions = { :is_trash => 0 }
		out = self.where( conditions).order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
  paginates_per 12
  
  def self.all
    self.public.order_by( :created_at => :desc )
  end
  
  def self.not_tagged
    Report.where( :tag_id => nil, :city => nil )
  end
  
  def self.for_homepage args
    begin
      tag_ids = args[:main_tag].children_tags.map { |tag| tag._id } + [ args[:main_tag]._id ]
      return Report.where( :tag_id.in => tag_ids ).page args[:page]
    rescue
      return Report.page args[:page]  
    end
  end

  def self.clear
    if Rails.env.test?
      Report.all.each { |r| r.remove }
    end
  end

end