
FactoryGirl.define do
  
  
  factory :pi_pt, :class => UserProfile do
    
    lang 'pt'
    user User.where( :username => 'piousbox' ).first
    
  end
  
  factory :pi_en, :class => UserProfile do
    
    lang 'en'
    user User.where( :username => 'piousbox' ).first
    
  end
  
  factory :pi_ru, :class => UserProfile do
    
    lang 'ru'
    user User.where( :username => 'piousbox' ).first
    
  end
  
end