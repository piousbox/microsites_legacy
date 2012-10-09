
class CitiesTasks
  
  def self.to_mongoid
    
    old_cities = SqlCity.find :all
    old_cities.each do |old|
      
      new = City.new
      new.name = old.name
      new.cityname = old.name_seo
      # new.descr = old.descr
      new.x = old.x
      new.y = old.y
      
      new.created_at = old.created_at
      new.updated_at = old.updated_at
      
      new.is_feature = old.is_feature
      
      new.save
      
    end
    
  end
  
end