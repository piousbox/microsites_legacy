class User < ActiveRecord::Base
  
  devise :registerable,
    :recoverable, 
    :trackable, 
    :validatable,
    :rememberable,
    :token_authenticatable, 
    :database_authenticatable,
    :encryptable, 
    # :lockable,
    # :timeoutable, 
    # :confirmable,
    :omniauthable, 
    :omniauth_providers => [ :facebook ]
      
  validates_uniqueness_of :email
  
  has_many :reports, :conditions => { :is_trash => 0, :is_public => 1 }
  has_many :galleries, :conditions => { :is_trash => 0, :is_public => 1 }
  
	has_many :cities_users
  has_many :cities, :through => :cities_users

	belongs_to :profile_photo, :class_name => 'Photo'
  
  has_many :photos
  
  has_many :communities_users
  
  belongs_to :city
  
  def self.per_page
    21
  end
  
  def self.n_reports_per_page
    6
  end
  
  def self.n_galleries_per_page
    9
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authentications.find_by_provider('facebook').token)
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(:name => auth.extra.raw_info.name,
        :provider => auth.provider,
        :uid => auth.uid,
        :email => auth.info.email,
        :password => Devise.friendly_token[0,20]
      )
    end
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  protected

  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
	
end
