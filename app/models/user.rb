

class User
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # :recoverable, :trackable, :validatable, :rememberable,
  # :token_authenticatable, 
  # :confirmable, :lockable, :timeoutable, 
  devise :registerable
  devise :database_authenticatable, :authentication_keys => [ :email ]
  # devise :omniauthable, :omniauth_providers => [ :facebook ]
  # devise :encryptable, :encryptor => :sha1base64
  
  field :email, :type => String
  validates :email, :presence => true, :uniqueness => true

  field :username, :type => String
  validates :username, :presence => true, :uniqueness => true
  
  field :name, :type => String
  validates :name, :presence => true
  
  field :encrypted_password, :type => String
  
  field :group_id, :type => Integer, :default => 3

  field :a1, :type => String
  field :a2, :type => String
  field :a3, :type => String
  field :a4, :type => String
  field :a5, :type => String
  field :scratchpad, :type => String
  field :github_path, :type => String
  field :facebook_path, :type => String
  field :linkedin_path, :type => String
  
  has_many :reports
  has_many :photos
  has_and_belongs_to_many :viewable_photos, :class_name => 'Photo', :inverse_of => :viewer
  has_many :user_profiles
  has_many :days
  has_many :galleries
  has_many :cities_users

  field :is_trash, :type => Boolean, :default => false
  scope :fresh, where( :is_trash => false )
  scope :trash, where( :is_trash => true )
  
  has_one :profile_photo, :class_name => 'Photo', :inverse_of => :profile_user
  belongs_to :guide_city, :class_name => 'City', :inverse_of => :guide

  def self.list conditions = { :is_trash => false }
		out = self.where( conditions).order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
#  field :about, :type => String
#  field :education, :type => String
#  field :objectives, :type => String
#  field :current_employment, :type => String
#  field :past_employment, :type => String
#  
#  field :pdf_resume_path, :type => String
#  field :doc_resume_path, :type => String
#  http://s3.amazonaws.com/ish-assets/hunter/201208.pudeyev-resume.pdf
  
end