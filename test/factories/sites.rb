FactoryGirl.define do
  factory :test_site, :class => Site do
    domain 'test.host'
    subhead 'blah blah'
    title 'Title testt'
    lang 'en'
  end

  factory :site, :class => Site do
    domain 'test.host'
    subhead 'blah blah'
    title 'Title testt'
    lang 'en'
  end

  factory :site_pi, :class => Site do
    domain 'pi.local'
    subhead 'blah blah'
    title 'Title 7'
    lang 'en'
  end

  factory :site_piousbox, :class => Site do
    domain 'piousbox.com'
    subhead 'blah blah'
    title 'Title 1'
    lang 'en'
  end

  factory :site_piousbox_ru, :class => Site do
    domain 'piousbox.com'
    subhead 'blah blah'
    title 'Title 2'
    lang 'ru'
  end

  factory :site_piousbox_pt, :class => Site do
    domain 'piousbox.com'
    subhead 'blah blah'
    title 'Title pt'
    lang 'pt'
  end

  factory :site_travel_local, :class => Site do
    domain 'travel.local'
    subhead 'blah blah'
    title 'Title en'
    lang 'en'
  end

  factory :site_mobi, :class => Site do
    domain 'travel-guide.mobi'
    subhead 'blah blah'
    title 'blah blah'
    lang 'en'
  end

  factory :site_pt, :class => Site do
    domain 'test.host'
    subhead 'blah blah'
    title 'Title kkk'
    lang 'pt'
  end

  factory :site_qxt, :class => Site do
    domain 'organizer.annesque.com'
    subhead 'blah blah'
    title 'Title_0'
    lang 'en'
  end

  factory :site_example, :class => Site do
    domain 'www.example.com'
    subhead 'blah blahff'
    title 'Title_ffff'
    lang 'en'
  end
  
end
