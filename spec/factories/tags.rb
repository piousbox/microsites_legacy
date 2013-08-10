FactoryGirl.define do

  factory :tag_old, :class => Tag do
    name 'Tag test.local'
    name_seo 'Tag'
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
  end

  factory :user_tag, :class => Tag do
    name 'Tag 2'
    name_seo 'simple'
  end

  factory :tag_travel, :class => Tag do
    name 'Travel'
    name_seo 'travel'
  end

  factory :tag_pi, :class => Tag do
    name 'Travel'
    name_seo 'travel'
  end

  factory :tag_sedux, :class => Tag do
    name 'Sedux'
    name_seo 'Sedux'
  end

  factory :tag_qxt, :class => Tag do
    name 'qxt'
    name_seo 'qxt'
  end

  factory :tag_feature_1, :class => Tag do
    name 'Feature 1'
    name_seo 'feature-1'
    is_feature true
  end

  factory :tag_local, :class => Tag do
    name 'Feature 1aaa'
    name_seo 'feature-1aaa'
    is_feature true
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
  end

  factory :tag_new, :class => Tag do
    name 'New Tag'
    name_seo 'new-tag'

    after :build do |tag|
      r = Report.first
      r.tag_id = tag.id
      r.save
    end
  end

end
