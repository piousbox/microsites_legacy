

class Newsitem < ActiveRecord::Base
  
  belongs_to :report
  belongs_to :user
  belongs_to :city
  belongs_to :photo
  
  
end

