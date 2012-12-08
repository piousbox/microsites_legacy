

class Addressbookitem

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :descr, :type => String
  field :date, :type => DateTime

  belongs_to :user

end