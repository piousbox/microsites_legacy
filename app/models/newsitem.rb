

class Newsitem

  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :city
  
end