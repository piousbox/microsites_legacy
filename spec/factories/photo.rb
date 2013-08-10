
FactoryGirl.define do
  
  factory :photo do
    name 'blah blah'
    is_public 1
    is_trash 0
    # photo open(url)
    user User.all.first
  end

end
