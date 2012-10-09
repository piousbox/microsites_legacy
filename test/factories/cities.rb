
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
  
end