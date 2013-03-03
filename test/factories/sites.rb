
FactoryGirl.define do

  factory :sedux_site, :class => Site do
    domain 'test.host'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :test_site, :class => Site do
    domain 'blog.test.local'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :test_site_2, :class => Site do
    domain 'test.host'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :test_site_3, :class => Site do
    domain 'test.local'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :site_blog, :class => Site do
    domain 'blog.sedux.local'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :site_pi, :class => Site do
    domain 'pi.local'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :site_piousbox, :class => Site do
    domain 'piousbox.com'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :site_piousbox_ru, :class => Site do
    domain 'piousbox.com'
    subhead 'blah blah'
    title 'Title'
    lang 'ru'
  end

  factory :site_piousbox_pt, :class => Site do
    domain 'piousbox.com'
    subhead 'blah blah'
    title 'Title'
    lang 'pt'
  end

  factory :site_travel_local, :class => Site do
    domain 'travel.local'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :site, :class => Site do
    domain 'site.com'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end

  factory :site_pt, :class => Site do
    domain 'test.host'
    subhead 'blah blah'
    title 'Title'
    lang 'pt'
  end

  factory :site_qxt, :class => Site do
    domain 'organizer.annesque.com'
    subhead 'blah blah'
    title 'Title'
    lang 'en'
  end
  
end