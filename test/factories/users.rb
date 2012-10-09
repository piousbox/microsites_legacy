
FactoryGirl.define do
  
  
  factory :user do
    
    email 'user@user.com'
    username 'simple'
    group_id 1
    
    password 's3cret'
    encrypted_password '$2a$10$PoBe1MvkoGJsjMVTEjKqgeBUp.xdfzWoiDjBzQhtLAj16NqIa2fOy'
    
  end
  
end