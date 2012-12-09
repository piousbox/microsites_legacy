
FactoryGirl.define do
  
  
  factory :tag, :class => Tag do
    name 'Tag test.local'
    name_seo 'Tag'
    domain 'blog.test.local'
    
  end
  
  factory :tag1, :class => Tag do
    name 'Tag 1'
    name_seo 'Tag-1'
    parent_tag :tag
    
  end
  
  factory :tag_cac, :class => Tag do
    name 'Tag CAC'
    name_seo 'cac'
    parent_tag :tag
    
  end
  
  factory :tag2, :class => Tag do
    name 'Tag 2'
    name_seo 'Tag-2'
    
    after(:create) do |tag|
      tag.parent_tag = Tag.where(:domain => 'blog.test.local').first
    end
    
  end

  factory :user_tag, :class => Tag do
    name 'Tag 2'
    name_seo 'simple'

    after(:create) do |tag|
      tag.parent_tag = Tag.where(:domain => 'blog.test.local').first
    end

  end
  
end