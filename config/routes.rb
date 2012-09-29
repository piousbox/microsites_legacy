Microsites2::Application.routes.draw do
  

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root :to => 'welcome#homepage'
  
  get 'about', :to => 'welcome#about', :as => :about
  get 'privacy', :to => 'welcome#privacy', :as => :privacy
  
  get 'article/:name_seo', :to => 'reports#show'
  get 'reports/:id', :to => 'reports#show'
  
  
  namespace :manager do
    root :to => 'tags#homepage'
    
    resources :tags
    
  end
  
end
