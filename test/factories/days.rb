


FactoryGirl.define do
  
  
  factory :day, :class => Day do
    date '2012-01-01'
    a1 'blah blah'
    a2 'la la la'
    user User.all[0]
  end
  
end