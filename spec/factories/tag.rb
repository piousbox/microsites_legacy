
FactoryGirl.define do
  factory :tag do
    name 'Tag name'
  end

  factory :tag1, :parent => :tag do
    name 'Tag 1'
  end

  factory :tag2, :parent => :tag do
    name 'Tag 2'
  end

end


