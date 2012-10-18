

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
  field :username, :type => String
  field :name, :type => String
  
  field :encrypted_password, :type => String
  
  field :group_id, :type => Integer
  
  has_many :reports
  has_many :photos
  has_many :user_profiles
  has_many :days
  has_many :galleries
  has_one :profile_photo, :class_name => 'Photo', :inverse_of => :profile_user
  
  
  
  field :github_path, :type => String
  field :facebook_path, :type => String
  field :linkedin_path, :type => String
  
#  field :about, :type => String
#  field :education, :type => String
#  field :objectives, :type => String
#  field :current_employment, :type => String
#  field :past_employment, :type => String
#  
#  field :pdf_resume_path, :type => String
#  field :doc_resume_path, :type => String
  # http://s3.amazonaws.com/ish-assets/hunter/201208.pudeyev-resume.pdf
  
end