
Microsites2::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root :to => 'welcome#homepage'
  
  get 'about', :to => 'welcome#about', :as => :about
  get 'privacy', :to => 'welcome#privacy', :as => :privacy
  
  get 'articles/read/:name_seo', :to => 'reports#show'
  get 'articles/:id', :to => 'reports#show'
  
  resources :reports
  
  namespace :manager do
    root :to => 'tags#homepage'
    resources :tags
    resources :reports
  end
  
end
