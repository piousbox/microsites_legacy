

class Video < ActiveRecord::Base
  
  set_table_name :videos

  belongs_to :user
  belongs_to :city
  
  def self.n_features
    5
  end 
  
  def self.first_feature
    self.first_features[0]
  end
  
  def self.first_features n = 1
    Video.find(:all,
      :conditions => { :is_public => 1, :is_trash => 0, :is_feature => 1 },
      :limit => n,
      :order => 'created_at desc'
    )
  end

end
