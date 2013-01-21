
class Video

  include Mongoid::Document
  include Mongoid::Timestamps

  field :descr, :type => String
  field :name, :type => String
  # name should probably be required and derived from other factors on create callback

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

  field :youtube_id, :type => String

  belongs_to :tag

  belongs_to :city

  belongs_to :user
  validates :user, :presence => true

end
