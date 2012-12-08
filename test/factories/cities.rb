
FactoryGirl.define do
  
  
  factory :city, :class => City do
    name 'city name'
    cityname 'city_name'
    is_feature '0'
    x '1'
    y '1'
  end
  
  factory :sf, :class => City do
    cityname 'San_Francisco'
    name 'San Francisco'
    is_feature '1'
    x '1'
    y '1'
    after(:create) { |r| r.profile_photo = Photo.first; r.save }

  end
  
  factory :rio, :class => City do
    
    name 'Rio Name'
    cityname 'rio'
    is_feature '1'
    after(:create) { |r| r.profile_photo = Photo.first; r.save }
    
    calendar_frame 'calendar'
    x '1.5'
    y '1.5'
    
  end
  
end