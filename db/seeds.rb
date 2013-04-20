
# sites
langs = [ 'en', 'ru', 'pt' ]
domains = [ 'pi.local' ]
langs.each do |lang|
  domains.each do |domain|
    old = Site.where( :lang => lang, :domain => domain ).first
    if old.blank?
      new_site = Site.new :lang => lang, :domain => domain
      new_site.save
    end
  end
end

# users
pi = User.create :email => 'piousbox@gmail.com', :password => 's1mple'
manager = User.create :email => 'manager@gmail.com', :password => 's1mple', :group_id => 1

# cities
cities = [ 'San Francisco', 'New York City', 'Chicago', 'Rio de Janeiro' ]
citynames = [ 'San_Francisco', 'New_York_City', 'Chicago', 'Rio_de_Janeiro' ]
cities.each do |city|
  citynames.each_with_index do |cityname, idx|
    old = City.where( :name => city ).first
    if old.blank?
      new_city = City.new :name => city, :cityname => cityname, :is_feature => false, :name_en => cityname, :name_pt => cityname, :name_ru => cityname
      # new_city.profile_photo_id = Photo.all[idx].id
      new_city.save
    end
  end
end
