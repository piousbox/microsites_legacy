
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
  
  def self.attach_reports_to_cities
    
    old_cities = SqlCity.find :all
    old_cities.each do |old_city|
      old_city.reports.each do |old_report|
        new_report = Report.where( :name_seo => old_report.name_seo ).first
        if new_report.blank?
          unless Rails.env.test?
            puts "this name_seo does not exist:"
            puts old_report.name_seo
          end
        else
          new_city = City.where( :cityname => old_report.city.name_seo ).first
          new_report.city = new_city
          new_report.save
        end
        
      end
      
    end
    
  end
  
end