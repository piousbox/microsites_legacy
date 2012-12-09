

class AppModel2

  include Mongoid::Document
  include Mongoid::Timestamps

  field :is_trash, :type => Boolean, :default => false
  scope :fresh, where( :is_trash => false )
  scope :trash, where( :is_trash => true )
  
end