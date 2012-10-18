ActiveAdmin.register User do     
  index do                            
    column :email    
    column :username
    # column :current_sign_in_at
    # column :last_sign_in_at           
    # column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email      
      f.input :username
      f.input :name
      
#      f.input :about
#      f.input :pdf_resume_path
#      f.input :doc_resume_path
      f.input :github_path
      f.input :facebook_path
      f.input :linkedin_path
      
#      f.input :education
#      f.input :objectives
#      f.input :current_employment
#      f.input :past_employment
      
    end                               
    f.buttons                         
  end                                 
end                                   
