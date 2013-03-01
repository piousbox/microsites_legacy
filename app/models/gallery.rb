
require 'string'

class Gallery < AppModel2
  
  belongs_to :tag
  belongs_to :city

  belongs_to :user
  validates :user, :presence => true
  field :username, :type => String
  
  field :name, :type => String

  field :galleryname, :type => String
  validates :galleryname, :uniqueness => true, :allow_nil => false

  field :subhead, :type => String
  
  field :descr, :type => String

  field :lang, :type => String, :default => 'en'

  field :is_public, :type => Boolean, :default => true
  field :is_trash, :type => Boolean, :default => false
  
  has_many :photos

  belongs_to :cities_user
  belongs_to :venue
  
  def self.no_city
    self.where( :city => nil )
  end
    
  def self.all
    self.where( :is_trash => false ).order_by( :created_at => :desc )
  end

  def self.n_per_manager_page
    20
  end
  
  set_callback(:create, :before) do |doc|
    doc.username = doc.user.username
    doc.galleryname = doc.name.to_simple_string

    if 0 == Site.where( :domain => 'piousbox.com', :lang => doc.lang ).length
      site = Site.new :domain => 'piousbox.com', :lang => doc.lang
      site.save
    end

    # for the homepage
    if doc.is_public
      n = Newsitem.new {}
      n.gallery = doc
      n.username = doc.user.username
      site = Site.where( :lang => doc.lang, :domain => 'piousbox.com' ).first
      site.newsitems << n
      flag = site.save
      if !flag
        puts! site.errors
      end
    end

    # for the city
    if !doc.city_id.blank? && doc.is_public
      city = City.find doc.city_id

      n = Newsitem.new {}
      n.gallery = doc
      n.username = doc.user.username

      city.newsitems << n
      flag = city.save
      unless flag
        puts! city.errors
      end
    end
  end

  def self.styles
    [ 'show_mini', 'show_long', 'show_photo' ]
  end

end

