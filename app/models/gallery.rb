
class Gallery < AppModel2
  
  belongs_to :tag
  belongs_to :city

  belongs_to :user
  validates :user, :presence => true
  field :username, :type => String
  
  belongs_to :cities_user
  
  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false

  field :galleryname, :type => String
  validates :galleryname, :uniqueness => true, :allow_nil => false

  field :subhead, :type => String
  
  field :descr, :type => String
  
  has_many :photos
  
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