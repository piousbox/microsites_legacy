
FactoryGirl.define do
  
  factory :city, :class => City do
    name 'city name'
    cityname 'city_name'
    is_feature false
    x '1'
    y '1'
    
  end
  
  factory :sf, :class => City do
    cityname 'San_Francisco'
    name 'San Francisco'
    is_feature false
    x '1'
    y '1'
    
  end

  factory :nyc, :class => City do
    cityname 'New_York_City'
    name 'New York City'
    is_feature false
    x '1'
    y '1'

  end
  
  factory :rio, :class => City do
    name 'Rio Name'
    cityname 'rio'
    is_feature false
    calendar_frame 'calendar'
    x '1.5'
    y '1.5'
    
  end

  factory :chicago, :class => City do
    name 'Chicago'
    cityname 'chicago'
    is_feature true
    calendar_frame 'calendar frame'
    x '1.4'
    y '1.1'
  end
  
end