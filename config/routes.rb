
Microsites2::Application.routes.draw do

  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :registrations => 'users/registrations'
  }

  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  root :to => 'welcome#home'
  get 'about', :to => 'travel#about', :as => :about
  get 'privacy', :to => 'welcome#privacy', :as => :privacy
  get 'help', :to => 'welcome#help', :as => :help

  get 'addressbookitems', :to => 'addressbookitems#index', :as => :search_addressbookitems
  get 'addressbookitems/search/:keyword', :to => 'addressbookitems#index', :as => :search_addressbookitems

  resources :days
  post 'days/search', :to => 'days#search', :as => :search_days
  
  # get 'photos/upload', :to => 'photos#upload', :as => :new_photo
  # post 'churn-photos', :to => 'photos#churn_photos', :as => :churn_photos
  match 'photos/driver-for/:gallery_id' => 'photos#driver', :as => :add_photos
  match 'photos/do_upload/:gallery_id/by/:username', :to => 'photos#do_upload', :as => :do_upload
  get 'photos/new_profile_photo', :to => 'photos#new', :defaults => { :is_profile => true }, :as => :new_profile_photo
  post 'photos/:id/move', :to => 'manager/photos#update', :as => :move_photo
  get 'photos/new-for-gallery/:gallery_id', :to => 'photos#new', :as => :new_photo_for_gallery
  resources :photos
  
  get 'tags/view/:name_seo', :to => 'tags#show', :as => :tag

  get 'users', :to => 'users#index', :as => :users
  get 'users/show/:username', :to => 'users#show', :as => :user
  get 'users/:username/resume', :to => 'users#show', :as => :user_resume
  get 'users/:username/resume/print', :to => 'users#show', :defaults => { :print => true }
  get 'users/:username/articles', :to => 'users#reports', :as => :user_reports
  get 'users/:username/galleries', :to => 'users#galleries', :as => :user_galleries
  match 'users/scratchpad', :to => 'users#scratchpad', :as => :scratchpad
  get 'users/account', :to => 'users#account', :as => :user_account
  get 'users/account', :to => 'users#account', :as => :account
  get 'users/sign_in', :to => 'users#sign_in', :as => :sign_in
  get 'users/organizer', :to => 'users#organizer', :as => :organizer
  put 'users/show/:id', :to => 'users#update'
  
  get 'users/report/:name_seo', :to => 'users#report', :as => :user_report
  get 'users/gallery/:galleryname', :to => 'users#gallery', :as => :user_gallery
  get 'users/in-city/:cityname', :to => 'users#index', :as => :users_in_city
  
  get 'venues/show/:name_seo', :to => 'venues#show', :as => :venue
  get 'venues/in-city/:cityname', :to => 'venues#index', :as => :venues_in_city
  # below, okk for deprecation
  match 'venues/:venue_type/in/:cityname' => redirect { |params, request| "/cities/travel-to/#{params[:cityname]}" }
  get 'venues/show/:name_seo/news', :to => 'venues#news', :as => :venue_news
  get 'venues/:venuename/:reportname', :to => 'venues#report', :as => :venue_report

  get 'cities/travel-to/:cityname', :to => 'cities#profile', :as => :city
  get 'cities/travel-to/:cityname/reports', :to => 'reports#index', :as => :reports_in_city
  get 'cities', :to => 'cities#index', :as => :cities
  get 'ish', :to => 'welcome#ish_home', :as => :ish_root
  get 'travel', :to => 'travel#home', :as => :travel_root
  
  get 'reports/view/:name_seo', :to => 'reports#show', :as => :report
  match 'reports/promo/:name_seo' => redirect { |params, request| "reports/view/#{params[:name_seo]}" }
  get 'reports/show/:name_seo', :to => 'reports#show'
  get 'reports/in-city/:cityname', :to => 'reports#index'
  post 'reports/search', :to => 'reports#search', :as => :search_reports
  post 'reports/search', :to => 'reports#search', :as => :my_search_reports, :defaults => { :my => true }
  get 'reports/search/:search_keyword', :to => 'reports#search'
  get 'my/reports', :to => 'reports#index', :as => :my_reports, :defaults => { :my => true }
  get 'reports/page/:reports_page', :to => 'reports#index'

  ##
  ## galleries
  ##
  post 'galleries/search', :to => 'galleries#search', :as => :search_galleries
  get 'galleries/search/:search_keyword', :to => 'galleries#search'
  # deprecated
  get 'galleries/view/:galleryname/:photos_page', :to => 'galleries#show'
  # deprecated
  get 'galleries/view/:galleryname', :to => 'galleries#show'
  get 'galleries/show/:galleryname/:photos_page', :to => 'galleries#show'
  get 'galleries/show/:galleryname', :to => 'galleries#show', :as => :gallery
  # get 'galleries/show/:galleryname/:photos_page' => redirect('galleries/view/:galleryname') # needed by google
  match 'galleries/show/:galleryname' => redirect { |params, request| "/galleries/view/#{params[:galleryname]}" }
  match 'galleries/show/:galleryname/:photos_page' => redirect { |params, request| "/galleries/view/#{params[:galleryname]}/#{params[:photos_page]}" }
  get 'galleries/show/:galleryname/photo/:photo_idx', :to => 'galleries#show_photo', :as => :gallery_show_photo
  get 'galleries/in-city/:cityname', :to => 'galleries#index', :as => :galleries_in_city
  get 'my/galleries', :to => 'galleries#index', :defaults => { :my => true }
  get 'galleries/:id/edit', :to => 'galleries#edit', :as => :edit_gallery
  post 'galleries/:id', :to => 'galleries#update', :as => :update_gallery
  get 'galleries/set_show_style', :to => 'galleries#set_show_style', :as => :galleries_set_show_style

  
  get 'videos/in-city/:cityname', :to => 'videos#index', :as => :videos_in_city
  get 'videos/view/:youtube_id', :to => 'videos#show'
  get 'videos/in-tag/:tagname', :to => 'videos#index', :as => :videos_in_tag

  # get 'set_locale', :to => 'welcome#set_locale', :as => :set_locale
  post 'set_city', :to => 'welcome#set_city', :as => :set_city

  get 'events/in-city/:cityname', :to => 'events#index', :as => :events_in_city
  
  resources :addressbookitems
  resources :cities_users
  resources :events
  resources :galleries
  resources :messages
  resources :reports
  resources :subscriptions
  resources :tags
  resources :videos
  resources :venues
  
  
  get 'my/timeline', :to => 'cities_users#index', :as => :my_timeline

  get 'sitemap', :to => 'utils/sitemaps#sitemap', :as => :sitemap
  get 'v', :to => 'utils/utils#version', :as => :version
  
  get 'google4b2e82b4dbbf505d', :to => 'utils/verification#one'
  get 'index.php/events/calendar/*everything' => redirect { |params, request| '/' }
  get 'index.php/events/view/*everything' => redirect { |params, request| '/' }
  get 'index.php/events/in/:cityname' => redirect { |params, request| "/cities/travel-to/#{params[:cityname]}" }
  get 'index.php' => redirect { |params, request| '/' }
  get 'venue_types/*everything' => redirect { |params, request| '/' }
  get 'venue_types' => redirect { |params, request| '/' }

  
  namespace :manager do
    root :to => 'welcome#homepage'

    get 'galleries/all_photos', :to => 'galleries#all_photos', :as => :all_photos
    
    
    get 'photos/no_gallery', :to => 'photos#no_gallery', :as => :photos_no_gallery

    get 'reports/features', :to => 'reports#index', :defaults => { :is_features => true }, :as => :feature_reports
    get 'reports/dones', :to => 'reports#index', :defaults => { :is_done => true }, :as => :done_reports
    get 'reports/undones', :to => 'reports#index', :defaults => { :is_undone => true }, :as => :undone_reports
    get 'reports/untagged', :to => 'reports#index', :defaults => { :is_untagged => true }, :as => :untagged_reports

    resources :addressbookitems
    resources :articles
    resources :cities
    resources :galleries
    resources :photos
    resources :reports
    resources :sites
    resources :tags
    resources :users
    resources :venues
    resources :videos


    get 'galleries/view/:galleryname', :to => 'galleries#show', :as => :gallery
    put 'galleries/view/:galleryname', :to => 'galleries#update', :as => :gallery
    # resources :galleries
    
  end

  delete 'manager/galleries/view/:galleryname', :to => 'manager/galleries#destroy'
  
  delete 'manager/tags/destroy_tags_reports', :to => 'tags#testroy', 
    :as => :destroy_tags_reports
    
  match 'manager/cities/search', :to => 'cities#search', :as => :search_manager_cities
  match 'manager/cities/:id/change_profile_pic', :to => 'manager/cities#change_profile_pic', :as => :change_profile_pic_manager_city
  get "/manager/cities/new-feature-for/:city_id", :to => 'manager/cities#new_feature', :as => :add_manager_feature_for_city
  post "/manager/cities/create-feature-for/:city_id", :to => 'manager/cities#create_feature', :as => :create_manager_feature_for_city
  get '/manager/cities/:city_id/edit-feature/:feature_id', :to => 'manager/cities#edit_feature', :as => :manager_city_edit_feature
  get "/manager/cities/new-newsitem-for/:city_id", :to => 'manager/cities#new_newsitem', :as => :add_manager_newsitem_for_city
  post "/manager/cities/create-newsitem-for/:city_id", :to => 'manager/cities#create_newsitem', :as => :create_manager_newsitem_for_city

  
  match 'manager/reports/search', :to => 'manager/reports#index', :as => :search_manager_reports
  post 'manager/reports/:id', :to => 'manager/reports#update', :as => :update_manager_report
  get 'manager/reports/:id', :to => 'manager/reports#show', :as => :show_manager_report
  match 'manager/reports/mark_features', :to => 'manager/reports#mark_features'
  match 'manager/reports/for-domain/sedux', :to => 'manager/reports#index', :as => :manager_reports_sedux, :defaults => { :this_domain => 'blog.sedux.net' }
  match 'manager/reports/for-domain/webdevzine', :to => 'manager/reports#index', :as => :manager_reports_webdevzine, :defaults => { :this_domain => 'blog.webdevzine.com' }
  get 'manager/reports/for-venue/:venuename', :to => 'manager/reports#new', :as => :new_manager_report_for_venue
  get 'manager/reports', :to => 'manager/reports#index', :as => :manager_feature_reports, :defaults => { :is_features => true }
  
  post "/manager/sites/create-newsitem-for/:site_id", :to => 'manager/sites#create_newsitem', :as => :create_manager_newsitem_for_site
  get '/manager/sites/:site_id/edit-feature/:feature_id', :to => 'manager/sites#edit_feature', :as => :manager_site_edit_feature
  put '/manager/sites/:site_id/update_feature/:feature_id', :to => 'manager/sites#update_feature', :as => :manager_sites_update_feature
  get '/manager/sites/new-newsitem-for/:site_id', :to => 'manager/sites#new_newsitem', :as => :add_manager_newsitem_for_site
  get "/manager/sites/new-feature-for/:site_id", :to => 'manager/sites#new_feature', :as => :add_manager_feature_for_site
  post "/manager/sites/create-feature-for/:site_id", :to => 'manager/sites#create_feature', :as => :create_manager_feature_for_site

  # venues
  # features
  get '/manager/venues/:name_seo/features/new', :to => 'manager/venues#new_feature', :as => :new_manager_feature_for_venue
  post '/manager/venues/:name_seo/features', :to => 'manager/venues#create_feature', :as => :manager_features_for_venue
  get '/manager/venues/:name_seo/features/:id/edit', :to => 'manager/venues#edit_feature', :as => :edit_manager_feature_for_venue
  put '/manager/venues/:name_seo/features/:id', :to => 'manager/venues#update_feature', :as => :manager_feature_for_venue
  # newsitems
  get '/manager/venues/:name_seo/newsitems/new', :to => 'manager/venues#new_newsitem', :as => :new_manager_newsitem_for_venue
  post '/manager/venues/:name_seo/newsitems', :to => 'manager/venues#create_newsitem', :as => :manager_newsitems_for_venue
  get '/manager/venues/:name_seo/newsitems/:id/edit', :to => 'manager/venues#edit_newsitem', :as => :edit_manager_newsitem_for_venue
  put '/manager/venues/:name_seo/newsitems/:id', :to => 'manager/venues#update_newsitem', :as => :manager_newsitem_for_venue

  ##
  ## admin &&
  ## old redirects
  ##
  match 'admin/*everything' => redirect { |params, request| '/' }
  match 'admin' => redirect { |params, request| '/' }
  match 'dictionaryitems/*everything' => redirect { |params, request| '/' }
  match 'dictionaryitems' => redirect { |params, request| '/' }
  match 'helps/*everything' => redirect { |params, request| '/' }
  match 'helps' => redirect { |params, request| '/' }
  match 'events/*everything' => redirect { |params, request| '/' }
  match 'events' => redirect { |params, request| '/' }

  namespace :econ do

    root :to => 'welcome#home'
    
    resources :edges
    resources :nodes
    
  end

end
