


FactoryGirl.define do


  factory :sedux_site, :class => Site do

    domain 'test.host'
    subhead 'blah blah'
    title 'Title'
    
  end

  factory :test_site, :class => Site do

    domain 'blog.test.local'
    subhead 'blah blah'
    title 'Title'

  end

end