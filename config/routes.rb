
Microsites2::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)

  root :to => 'welcome#home'
  
  # match 'blog' => 'blog#home', :constraints => { :subdomain => 'blog' }
  
  get 'blog', :to => 'blog#home', :as => :blog_root
  
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
  get 'users/account', :to => 'users#account', :as => :user_account
  
  get 'venues/show/:venuename', :to => 'venues#show'
  
  get 'cac', :to => 'cac#home', :as => :cac_root
  get 'cac/contact', :to => 'cac#contact', :as => :cac_contact
  get 'cac/about', :to => 'cac#about', :as => :cac_about
  get 'cac/technology', :to => 'cac#technology', :as => :cac_technology
  get 'cac/portfolio', :to => 'cac#portfolio', :as => :cac_portfolio
  get 'cac/team', :to => 'cac#team', :as => :cac_team
  get 'cac/services', :to => 'cac#services', :as => :cac_services
  get 'cac/subscribe', :to => 'cac#subscribe', :as => :cac_subscribe
  get 'cac/privacy', :to => 'cac#privacy', :as => :cac_privacy
  
  get 'ish', :to => 'ish#home', :as => :ish_root
  
  get 'travel', :to => 'travel#home', :as => :travel_root
  
  resources :reports
  resources :subscriptions
  resources :messages
  
  namespace :manager do
    root :to => 'tags#homepage'
    resources :tags
    resources :reports
    resources :articles
    
  end
  
  delete 'manager/tags/destroy_tags_reports', :to => 'tags#testroy', 
      :as => :destroy_tags_reports
  
end
