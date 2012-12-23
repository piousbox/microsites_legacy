

class Newsitem

  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :city

  belongs_to :photo
  belongs_to :report
  belongs_to :user

  field 'descr', :type => String
  
end