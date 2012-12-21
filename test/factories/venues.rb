
FactoryGirl.define do


  factory :venue do
    name 'blah'
    name_seo 'blah'
    after(:build) { |v| v.user = User.first }

  end


end