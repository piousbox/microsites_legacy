
FactoryGirl.define do

  factory :venue, :class => Venue do
    name 'blah'
    name_seo 'blah'
    is_public true
    after(:build) { |v| v.user = User.first }
  end

  factory :cac, :class => Venue do
    name 'Computational Arts Corp'
    name_seo 'cac'
    after(:build) { |v| v.user = User.first }
  end

end
