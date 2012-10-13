

class User
  
  include Mongoid::Document
  
  # :recoverable, :trackable, :validatable, :rememberable,
  # :token_authenticatable, 
  # :confirmable, :lockable, :timeoutable, 
  devise :registerable
  devise :database_authenticatable, :authentication_keys => [ :email ]
  # devise :omniauthable, :omniauth_providers => [ :facebook ]
  # devise :encryptable, :encryptor => :sha1base64
  
  field :email, :type => String
  field :username, :type => String
  
  field :encrypted_password, :type => String
  
  field :group_id, :type => Integer
  
  has_many :reports
  has_many :photos
  
  field :github_path, :type => String
  
end