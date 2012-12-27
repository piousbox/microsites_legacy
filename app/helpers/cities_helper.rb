

module CitiesHelper

  def image_city cityname
    image_tag 'icons/48x48/city.png'
  end
  
  def travel_to_path cityname
    city_path cityname
  end
  
  def city_path city
    if 'String' == city.class.name
      return "/cities/travel-to/#{city}"
    else
      "/cities/travel-to/#{city.cityname}"
    end
  end
  
end