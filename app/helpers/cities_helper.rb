

module CitiesHelper

  def image_city cityname
    image_tag 'icons/48x48/city.png'
  end
  
  def travel_to_path city_name
    "/cities/travel-to/#{city_name}"
  end
  
  def city_path city
    "/cities/travel-to/#{city.cityname}"
  end
  
end