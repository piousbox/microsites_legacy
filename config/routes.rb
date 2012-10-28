
Microsites2::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => { :sessions => "users/sessions" }
  ActiveAdmin.routes(self)
  # I actually need the line below
  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end
  
  root :to => 'welcome#home'
  
  match 'addressbookitems/search', :to => 'reports#search', :as => :search_addressbookitems
  
  get 'blog', :to => 'blog#home', :as => :blog_root
  get 'blog/about', :to => 'blog#about', :as => :blog_about
  
  get 'about', :to => 'welcome#about', :as => :about
  get 'privacy', :to => 'welcome#privacy', :as => :privacy
  
  resources :days
  post 'days/search', :to => 'days#search', :as => :search_days
  
  # get 'photos/upload', :to => 'photos#upload', :as => :new_photo
  # post 'churn-photos', :to => 'photos#churn_photos', :as => :churn_photos
  # match 'photos/driver-for/:galleryname' => 'photos#driver', :as => :add_photos
  # post 'photos/move' => 'photos#move'
  post 'photos/:id/move', :to => 'manager/photos#move', :as => :move_photo
  resources :photos
  
  get 'tags/view/:name_seo', :to => 'tags#show'
  get 'tags/:id', :to => 'tags#show'
  
  get 'users/:username/resume', :to => 'users#resume', :as => :user_resume
  get 'users/:username/resume/print', :to => 'users#resume', :as => :user_resume, :defaults => { :print => true }
  get 'users/:username/articles', :to => 'users#reports', :as => :user_reports
  get 'users/:username/galleries', :to => 'users#galleries', :as => :user_galleries
  get 'users', :to => 'users#index', :as => :users
#  get 'users/:username/services', :to => 'users#services', :as => :services
#  get 'users/:username/contact', :to => 'users#contact', :as => :contact
#  get 'users/:username/projects', :to => 'users#projects', :as => :projects
#  get 'users/:username/connect_with_me', :to => 'users#connect_with_me', :as => :connect_with_me
#  get 'users/:username/past_employers', :to => 'users#past_employers', :as => :past_employers
  get 'users/account', :to => 'users#account', :as => :user_account
  get 'users/sign_in', :to => 'users#sign_in', :as => :sign_in
  get 'users/organizer', :to => 'users#organizer', :as => :organizer
  # same as line above
  get 'users/organizer', :to => 'users#organizer', :as => :user_organizer
  get 'users/account', :to => 'users#account', :as => :account
  get 'my/photos', :to => 'users#photos', :as => :my_photos
  
  get 'venues/show/:venuename', :to => 'venues#show'
  
  get 'cac', :to => 'cac#home', :as => :cac_root
  get 'cac/slider', :to => 'cac#slider', :as => :cac_slider
  get 'cac/contact', :to => 'cac#contact', :as => :cac_contact
  get 'cac/news', :to => 'cac#news', :as => :cac_news
  get 'cac/about', :to => 'cac#about', :as => :cac_about
  get 'cac/technology', :to => 'cac#technology', :as => :cac_technology
  get 'cac/portfolio', :to => 'cac#portfolio', :as => :cac_portfolio
  get 'cac/team', :to => 'cac#team', :as => :cac_team
  get 'cac/services', :to => 'cac#services', :as => :cac_services
  get 'cac/subscribe', :to => 'cac#subscribe', :as => :cac_subscribe
  get 'cac/privacy', :to => 'cac#privacy', :as => :cac_privacy
  
  get 'cities/travel-to/:cityname', :to => 'cities#profile', :as => :city_profile
  get 'cities/travel-to/:cityname/reports', :to => 'cities#reports', :as => :city_reports
  
  get 'ish', :to => 'ish#home', :as => :ish_root
  
  get 'travel/about', :to => 'travel#about', :as => :mobi_about
  get 'travel', :to => 'travel#home', :as => :travel_root
  
  resources :reports
  get 'reports/view/:name_seo', :to => 'reports#show', :as => :report
  get 'reports/show/:name_seo', :to => 'reports#show'
  get 'reports/:id', :to => 'reports#show'
  get 'reports/in-city/:cityname', :to => 'reports#index'
  match 'reports/search', :to => 'reports#search', :as => :search_reports
  
  match 'galleries/search', :to => 'reports#search', :as => :search_galleries
  get 'galleries/show/:galleryname/:photos_page', :to => 'galleries#show'
  
  resources :galleries
  resources :subscriptions
  resources :messages
  # resources :users
  resources :cities
  
  
  namespace :manager do
    root :to => 'welcome#homepage'
    
    get 'galleries/all_photos', :to => 'galleries#all_photos', :as => :all_photos
    get 'photos/no_gallery', :to => 'photos#no_gallery', :as => :photos_no_gallery
    
    resources :tags
    resources :reports
    resources :articles
    resources :cities
    resources :galleries
    resources :photos
    
    
  end
  
  
  delete 'manager/tags/destroy_tags_reports', :to => 'tags#testroy', 
      :as => :destroy_tags_reports
    
  match 'manager/cities/search', :to => 'cities#search', :as => :search_manager_cities
  match 'manager/reports/search', :to => 'manager/reports#index', :as => :search_manager_reports
  match 'manager/reports/:id', :to => 'manager/reports#update', :as => :update_manager_report
end
