
class Newsitem

  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :city
  embedded_in :user
  embedded_in :venue

  belongs_to :photo
  belongs_to :report
  belongs_to :gallery

  field 'descr', :type => String
  field 'username', :type => String
  
end
