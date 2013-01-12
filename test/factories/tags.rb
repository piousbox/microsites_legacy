
FactoryGirl.define do
  
  
  factory :tag, :class => Tag do
    name 'Tag test.local'
    name_seo 'Tag'
    domain 'blog.test.local'

    after :build do |t|
      t.user = User.all.first
    end
    
  end
  
  factory :tag1, :class => Tag do
    name 'Tag 1'
    name_seo 'Tag-1'
    parent_tag :tag

    after :build do |t|
      t.user = User.all.first
    end
    
  end
  
  factory :tag_cac, :class => Tag do
    name 'Tag CAC'
    name_seo 'cac'
    parent_tag :tag

    after :build do |t|
      t.user = User.all.first
    end
    
  end
  
  factory :tag2, :class => Tag do
    name 'Tag 2'
    name_seo 'Tag-2'
    
    after :build do |tag|
      tag.parent_tag = Tag.where(:domain => 'blog.test.local').first
      tag.user = User.all.first
    end
    
  end

  factory :user_tag, :class => Tag do
    name 'Tag 2'
    name_seo 'simple'

    after :build do |tag|
      tag.parent_tag = Tag.where(:domain => 'blog.test.local').first
      tag.user = User.all.first
    end

  end

  factory :tag_travel, :class => Tag do
    name 'Travel'
    name_seo 'travel'
    domain 'pi.local'

    after :build do |tag|
      tag.parent_tag = Tag.where(:domain => 'blog.test.local').first
      tag.user = User.all[0]
    end

  end
  
end