
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
  
  has_many :photos

  belongs_to :cities_user
  belongs_to :venue
  
  def self.no_city
    self.where( :city => nil )
  end
    
  def self.all
    self.order_by( :created_at => :desc )
  end

  def self.n_per_manager_page
    20
  end
  
  set_callback(:create, :before) do |doc|
    doc.username = doc.user.username
  end

end

