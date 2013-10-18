
FactoryGirl.define do

  factory :site do
    domain 'piousbox.com'
    lang 'en'
  end

  factory :site_wdz, :class => Site do
    domain 'webdevzine.com'
    lang 'en'
  end

end

 
