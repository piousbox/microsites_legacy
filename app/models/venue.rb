

class Venue < AppModel2
  
  field :name, :type => String
  
  belongs_to :city
  
end