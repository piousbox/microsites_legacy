
class Feature
  
  include Mongoid::Document
  include Mongoid::Timestamps

  #  field 'descr', :type => String
  #  field 'username', :type => String

  
  #  belongs_to :photo
  #  belongs_to :report
  #  belongs_to :gallery
  #

  embedded_in :venue

end
