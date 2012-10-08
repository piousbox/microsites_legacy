
FactoryGirl.define do
  
  
  factory :city, :class => City do
    name 'city name'
    cityname 'city_name'
    
  end
  
  factory :sf, :class => City do
    cityname 'San_Francisco'
    name 'San Francisco'
    
  end
  
end