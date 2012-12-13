
class Gallery < AppModel2
  
  belongs_to :tag
  belongs_to :city
  belongs_to :user
  belongs_to :cities_user
  
  field :name, :type => String
  field :galleryname, :type => String
  field :subhead, :type => String
  field :descr, :type => String
  
  has_many :photos
  
  def self.no_city
    self.where( :city => nil )
  end
    
  
  
end