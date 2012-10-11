
FactoryGirl.define do
  
  
  factory :city, :class => City do
    name 'city name'
    cityname 'city_name'
    is_feature '0'

  end
  
  factory :sf, :class => City do
    cityname 'San_Francisco'
    name 'San Francisco'
    is_feature '1'
  end
  
  factory :rio, :class => City do
    cityname 'Rio Name'
    name 'rio'
    is_feature '1'
    calendar_frame 'calendar'
    
  end
  
end