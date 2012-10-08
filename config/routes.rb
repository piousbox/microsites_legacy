
Microsites2::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)

  root :to => 'welcome#home'
  
  # match 'blog' => 'blog#home', :constraints => { :subdomain => 'blog' }
  
  get 'about', :to => 'welcome#about', :as => :about
  get 'privacy', :to => 'welcome#privacy', :as => :privacy
  
  get 'articles/read/:name_seo', :to => 'reports#show'
  get 'articles/:id', :to => 'reports#show'
  
  
  get 'tags/view/:name_seo', :to => 'tags#show'
  get 'tags/:id', :to => 'tags#show'
  
  get 'users/:username/services', :to => 'users#services', :as => :services
  get 'users/:username/resume', :to => 'users#resume', :as => :resume
  get 'users/:username/contact', :to => 'users#contact', :as => :contact
  get 'users/:username/projects', :to => 'users#projects', :as => :projects
  get 'users/:username/connect_with_me', :to => 'users#connect_with_me', :as => :connect_with_me
  get 'users/:username/past_employers', :to => 'users#past_employers', :as => :past_employers
  
  resources :reports
  
  namespace :manager do
    root :to => 'tags#homepage'
    resources :tags
    resources :reports
    resources :articles
    
  end
  
  delete 'manager/tags/destroy_tags_reports', :to => 'tags#testroy', 
      :as => :destroy_tags_reports
  
end
