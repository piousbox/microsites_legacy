
class Report   

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  validates :name, :presence => true

  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :presence => true

  field :descr, :type => String

  field :is_trash, :type => Boolean, :default => false
  field :is_public, :type => Boolean, :default => true
  scope :public, where( :is_public => true )
  field :is_feature, :type => Boolean, :default => false
  field :is_done, :type => Boolean, :default => true

  default_scope where( :is_public => true, :is_trash => false ).order_by( :created_at => :desc )
  
  field :x, :type => Float
  field :y, :type => Float

  field :lang, :type => String, :default => 'en'
  
  field :username, :type => String, :default => 'anonymous'
  validates :username, :presence => true, :allow_nil => false
  belongs_to :user
  validates :user, :presence => true, :allow_nil => false

  field :subhead, :type => String
  
  belongs_to :tag
  belongs_to :city
  belongs_to :site
  has_and_belongs_to_many :venues
  belongs_to :cities_user
  
  has_one :photo

  field :n_upvotes, :default => 0
  field :n_spamvotes, :default => 0
  
  def self.list conditions = { :is_trash => false }
    out = self.where( conditions).order_by( :name => :asc )
    [['', nil]] + out.map { |item| [ item.name, item.id ] }
  end

  PER_PAGE = 8  
  def self.paginates_per
    self::PER_PAGE
  end

  def venue
    self.venues[0] || nil
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
      self.unscoped.each { |r| r.remove }
    end
  end

  def self.not_tagged
    Report.where( :tag_id => nil, :city => nil )
  end
  
  set_callback :create, :before do |doc|
    if doc.is_public && !doc.venue_ids.blank?
      doc.venue_ids.each do |venue_id|
        v = Venue.find venue_id
        u = User.find doc.user_id
        n = Newsitem.new
        n.username = u.username unless u.blank?
        n.report = doc
        v.newsitems << n
        v.save
      end
    end
  end

end
