
FactoryGirl.define do
  
  
  factory :user do
    
    email 'user@user.com'
    username 'simple'
    name 'simple'
    group_id 1
    
    password 's3cret'
    encrypted_password '$2a$10$PoBe1MvkoGJsjMVTEjKqgeBUp.xdfzWoiDjBzQhtLAj16NqIa2fOy'
    
  end
  
  factory :piousbox, :class => User do
    email 'piousbox@gmail.com'
    username 'piousbox'
    name 'simple'

    group_id 1
    password 's3cret'
    encrypted_password '$2a$10$PoBe1MvkoGJsjMVTEjKqgeBUp.xdfzWoiDjBzQhtLAj16NqIa2fOy'
    
  end
  
  factory :admin, :class => User do
    email 'admin@gmail.com'
    username 'admin'
    name 'simple'

    group_id 1
    password 's3cret'
    encrypted_password '$2a$10$PoBe1MvkoGJsjMVTEjKqgeBUp.xdfzWoiDjBzQhtLAj16NqIa2fOy'
    
  end

  factory :manager, :class => User do
    email 'manager@gmail.com'
    username 'manager'
    name 'simple'
    
    group_id 2
    password 's3cret'
    encrypted_password '$2a$10$PoBe1MvkoGJsjMVTEjKqgeBUp.xdfzWoiDjBzQhtLAj16NqIa2fOy'

  end
  
end