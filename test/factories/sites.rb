
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

  factory :test_site_2, :class => Site do
    domain 'test.host'
    subhead 'blah blah'
    title 'Title'

  end

  factory :test_site_3, :class => Site do
    domain 'test.local'
    subhead 'blah blah'
    title 'Title'

  end

  factory :site_blog, :class => Site do
    domain 'blog.sedux.local'
    subhead 'blah blah'
    title 'Title'

  end

  factory :site_pi, :class => Site do
    domain 'pi.local'
    subhead 'blah blah'
    title 'Title'
    
  end
  
end