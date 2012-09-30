
Microsites2::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root :to => 'welcome#homepage'
  
  get 'about', :to => 'welcome#about', :as => :about
  get 'privacy', :to => 'welcome#privacy', :as => :privacy
  
  get 'articles/read/:name_seo', :to => 'reports#show'
  get 'articles/:id', :to => 'reports#show'
  
  
  get 'tags/view/:name_seo', :to => 'tags#show'
  get 'tags/:id', :to => 'tags#show'
  
  resources :reports
  
  namespace :manager do
    root :to => 'tags#homepage'
    resources :tags
    resources :reports
    
    
  end
  
  delete 'manager/tags/destroy_tags_reports', :to => 'tags#testroy', 
      :as => :destroy_tags_reports
    
end
