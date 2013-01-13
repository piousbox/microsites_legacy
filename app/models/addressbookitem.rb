
class Addressbookitem < AppModel2

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :city
  belongs_to :cities_user
  
  field :name, :type => String
  field :descr, :type => String

end
