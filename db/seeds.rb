
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
new_users = [
  [ 'piousbox@gmail.com', 3 ],
  [ 'manager@gmail.com', 1 ],
  [ 'user_1@gmail.com', 3 ],
  [ 'user_2@gmail.com', 3 ],
  [ 'user_3@gmail.com', 3 ]
]
new_users.each do |u|
  old = User.where( :email => u[0] ).first
  if old.blank?
    new = User.new :email => u[0], :username => u[0], :name => u[0], :password => 's1mple', :group_id => u[1]
    new.save && puts( 'user+' )
  end
end

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
