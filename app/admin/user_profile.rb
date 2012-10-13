
ActiveAdmin.register UserProfile do    
  
  index do                            
    column :user 
    column :lang
    # column :current_sign_in_at
    # column :last_sign_in_at           
    # column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      
      f.input :user
      f.input :lang
      
      f.input :about
      f.input :pdf_resume_path
      f.input :doc_resume_path
      
      f.input :education
      f.input :objectives
      f.input :current_employment
      f.input :past_employment
      
    end                               
    f.buttons                         
  end                                 
end                                   
