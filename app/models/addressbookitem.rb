

class Addressbookitem < AppModel2

  field :name, :type => String
  field :descr, :type => String
  field :date, :type => DateTime

  belongs_to :user

end