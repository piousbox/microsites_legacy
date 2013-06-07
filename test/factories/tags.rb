FactoryGirl.define do

  fRavi Duvvuri.actory :tag_old, :class => Tag do
    name 'Tag test.local'
    name_seo 'Tag'

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
      tag.user = User.all.first
    end
  end

  factory :user_tag, :class => Tag do
    name 'Tag 2'
    name_seo 'simple'

    after :build do |tag|
      tag.user = User.all.first
    end

  end

  factory :tag_travel, :class => Tag do
    name 'Travel'
    name_seo 'travel'

    after :build do |tag|
      tag.user = User.all[0]
    end
  end

  factory :tag_pi, :class => Tag do
    name 'Travel'
    name_seo 'travel'
    is_public = true
    is_trash = false

    after :build do |tag|
      tag.user = User.all[0]
    end
  end

  factory :tag_sedux, :class => Tag do
    name 'Sedux'
    name_seo 'Sedux'

    after :build do |tag|
      tag.user = User.all.first
    end
  end

  factory :tag_qxt, :class => Tag do
    name 'qxt'
    name_seo 'qxt'

    after :build do |tag|
      tag.user = User.all.first
    end
  end

  factory :tag_feature_1, :class => Tag do
    name 'Feature 1'
    name_seo 'feature-1'
    is_feature true
    is_trash false
    is_public true

    after :build do |tag|
      tag.user = User.all.first
    end
  end

  factory :tag_local, :class => Tag do
    name 'Feature 1aaa'
    name_seo 'feature-1aaa'
    is_feature true
    is_trash false
    is_public true
    after :build do |tag|
      tag.user = User.all.first
    end
  end

  # sequenced
  factory :tag, :class => Tag do
    sequence( :name ) do |n|
      "Tag name #{n}"
    end
    sequence( :name_seo ) do |n|
      "tag-name-seo-#{n}"
    end
    is_feature false
    is_public true

    after :build do |t|
      t.user = User.all.first || User.new
    end
  end

  # sequenced
  factory :feature_tag, :class => Tag do
    sequence( :name ) do |n|
      "Feature Tag name #{n}"
    end
    sequence( :name_seo ) do |n|
      "f-tag-name-seo-#{n}"
    end
    is_feature true
    is_public true

    after :build do |t|
      t.user = User.all.first || User.new
    end
  end

end
