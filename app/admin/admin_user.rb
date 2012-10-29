ActiveAdmin.register AdminUser do     
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.buttons                         
  end                                 
end                                   


ActiveAdmin.register CitiesUser do
  
  index do                            
    column :date
    column :city
    column :user
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :date
      f.input :city
      f.input :user
    end                               
    f.buttons                         
  end                                 
end                                   
