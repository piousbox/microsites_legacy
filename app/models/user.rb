
class User
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # :recoverable, :trackable, :validatable, :rememberable,
  # :token_authenticatable, 
  # :confirmable, :lockable, :timeoutable, 
  devise :registerable
  devise :database_authenticatable, :authentication_keys => [ :email ]
  # devise :omniauthable, :omniauth_providers => [ :facebook ]
  devise :encryptable, :encryptor => :sha1base64
  
  field :email, :type => String
  validates :email, :presence => true, :uniqueness => true

  field :username, :type => String
  validates :username, :presence => true, :uniqueness => true
  
  field :name, :type => String
  validates :name, :presence => true
  
  field :encrypted_password, :type => String
  
  field :group_id, :type => Integer, :default => 3

  field :scratchpad, :type => String
  field :github_path, :type => String
  field :facebook_path, :type => String
  field :stackoverflow_path, :type => String

  field :is_feature, :type => Boolean, :default => false
  field :is_trash, :type => Boolean, :default => false

  field :display_ads, :type => Boolean, :default => true
  field :display_help, :type => Boolean, :default => true
  
  has_many :reports
  has_many :photos
  has_many :user_profiles
  has_many :days
  has_many :galleries
  has_many :cities_users

  has_many :owned_venues, :class_name => 'Venue', :inverse_of => :owner
  has_one :profile_photo, :class_name => 'Photo', :inverse_of => :profile_user

  belongs_to :guide_city, :class_name => 'City', :inverse_of => :guide
  belongs_to :current_city, :class_name => 'City', :inverse_of => :guide
  has_and_belongs_to_many :venues

  has_and_belongs_to_many :viewable_photos, :class_name => 'Photo', :inverse_of => :viewer

  def self.list conditions = { :is_trash => false }
    out = self.where( conditions).order_by( :name => :asc )
    [['', nil]] + out.map { |item| [ item.name, item.id ] }
  end

  embeds_many :newsitems

  def self.all
    self.order_by( :created_at => :desc )
  end

  def self.clear
    if Rails.env.test?
      User.all.each { |r| r.remove }
    end
  end

  def create_newsitem args = {}
    unless args[:photo].blank?
      n = Newsitem.new
      n.photo = args[:photo]
      n.descr = 'uploaded new photo on'
      n.username = self.username
      self.newsitems << n
      self.save
    end
  end
  
  def self.per_page
    16
  end

end
