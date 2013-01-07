
FactoryGirl.define do


  factory :venue do
    name 'blah'
    name_seo 'blah'
    after(:build) { |v| v.user = User.first }

  end

  factory :cac do
    name 'Computational Arts Corp'
    name_seo 'cac'
    after(:build) { |v| v.user = User.first }

  end


end