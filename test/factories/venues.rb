
FactoryGirl.define do

  factory :venue, :class => Venue do
    name 'blah'
    name_seo 'blah'
    is_public true
    after(:build) do |v|
      v.user = User.first
      v.city = City.where( :cityname => 'San_Francisco' ).first
    end
  end

  factory :cac, :class => Venue do
    name 'Computational Arts Corp'
    name_seo 'cac'
    after(:build) do |v|
      v.user = User.first
      v.city = City.where( :cityname => 'San_Francisco' ).first
    end
  end

end
