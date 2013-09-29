Microsites2::Application.routes.draw do

  root :to => 'welcome#home'

  scope "/:locale", :constraints => { :locale => /en|ru|pt/ } do
    root :to => 'welcome#home'
    get 'about', :to => 'welcome#about', :as => :about
    
    devise_for :users, :controllers => {
      :sessions => "users/sessions",
      :registrations => 'users/registrations'
    }

    get "sites/:domainname.html", :to => "sites#show", :as => :site, :constraints => { :domainname => /.*/, :format => /xml|html|json/ }
    scope 'sites/:domainname', :constraints => { :domainname => /.*/, :format => /xml|html|json/ }, :as => :sites do
      get 'features', :to => 'sites#features', :as => :features
      get 'features/page/:features_page', :to => 'sites#features'
      get 'newsitems/page/:newsitems_page', :to => 'sites#show'

      get 'reports', :to => 'reports#index', :as => :reports
      get 'reports/page/:reports_page', :to => 'reports#index'

      get 'galleries', :to => 'galleries#index', :as => :galleries
      get 'galleries/page/:galleries_page', :to => 'galleries#index'
    end

    get 'reports', :to => 'reports#index', :as => :reports
    get 'reports/page/:reports_page', :to => 'reports#index' # @deprecated, but keep it for Google
    get 'reports/view/:name_seo', :to => 'reports#show', :as => :report
    get 'reports/show/:name_seo', :to => 'reports#show' # @deprecated, I think I'll go with `view` word.
    put 'reports/:id', :to => 'reports#update', :as => :update_report
    get 'reports/:id/edit', :to => 'reports#edit', :as => :edit_report
    get 'reports/new', :to => 'reports#new', :as => :new_report
    post 'reports', :to => 'reports#create'
    resources :reports

    get 'galleries', :to => 'galleries#index', :as => :galleries
    get 'galleries/page/:galleries_page', :to => 'galleries#index' # @deprecated, keep it for Google
    get 'galleries/new', :to => 'galleries#new', :as => :new_gallery
    # @deprecated, instead of `show` there should be `style`
    get 'galleries/show/:galleryname/:photo_idx', :to => 'galleries#show', :as => :gallery, :constraints => { :photo_idx => /.*/ }
    # @deprecated, instead of `show` there should be `style`
    get 'galleries/show/:galleryname', :to => 'galleries#show'
    get 'galleries/:style/:galleryname', :to => 'galleries#show', :as => :gallery_show_style, :constraints => { :style => /show_long|show_mini|show/ }
    get 'galleries/:id/edit', :to => 'galleries#edit', :as => :edit_gallery
    post 'galleries/:id', :to => 'galleries#update', :as => :update_gallery
    post 'galleries', :to => 'galleries#create'
    resources :galleries

    # get 'photos/upload', :to => 'photos#upload', :as => :new_photo
    # post 'churn-photos', :to => 'photos#churn_photos', :as => :churn_photos
    match 'photos/driver-for/:gallery_id' => 'photos#driver', :as => :add_photos
    match 'photos/do_upload/:gallery_id/by/:username', :to => 'photos#do_upload', :as => :do_upload
    get 'photos/new_profile_photo', :to => 'photos#new', :defaults => { :is_profile => true }, :as => :new_profile_photo
    get 'photos/new-for-gallery/:gallery_id', :to => 'photos#new', :as => :new_photo_for_gallery
    resources :photos
  
    get '/users', :to => 'users#index', :as => :users
    get '/users/show/:username', :to => 'users#show', :as => :user
    put '/users/:id', :to => 'users#update', :as => :update_user
    get '/users/:username/resume', :to => 'users#show', :as => :user_resume
    get '/users/:username/resume/print', :to => 'users#show', :defaults => { :print => true }
    get '/users/:username/articles', :to => 'users#reports'
    get '/users/:username/articles/page/:reports_page', :to => 'users#reports'
    get '/users/:username/reports', :to => 'users#reports', :as => :user_reports
    get '/users/:username/reports/show/:name_seo', :to => 'users#report', :as => :user_report
    get '/users/:username/galleries', :to => 'users#galleries', :as => :user_galleries
    match '/users/scratchpad', :to => 'users#scratchpad', :as => :scratchpad
    get '/users/sign_in', :to => 'users#sign_in', :as => :sign_in
    get '/users/organizer', :to => 'users#organizer', :as => :organizer
    put '/users/show/:id', :to => 'users#update'
    get '/users/new_profile', :to => 'users#new_profile', :as => :new_user_profile
    get '/users/:username/profiles/:profile_id/edit', :to => 'users#edit_profile', :as => :edit_user_profile
    put '/users/:username/profiles/:profile_id', :to => 'users#update_profile', :as => :update_profile
    get '/users/gallery/:galleryname', :to => 'users#gallery', :as => :user_gallery
    get '/users/in-city/:cityname', :to => 'users#index', :as => :users_in_city
    post '/user_profiles', :to => 'users#create_profile'
    match '/users/search', :to => 'users#index', :as => :users_search
    get '/users/:username/github', :to => 'users#github_page', :as => :user_github
    get '/settings', :to => 'users#edit', :as => :settings
    # resources :user_profile

    get 'tags', :to => 'tags#index', :as => :tags
    get 'tags/:tagname', :to => 'tags#show'
    get 'tags/view/:tagname', :to => 'tags#show', :as => :tag

    get 'v', :to => 'utils/utils#version', :as => :version
    get 'sitemap', :to => 'utils/sitemaps#sitemap', :as => :sitemap

    get 'videos', :to => 'videos#index', :as => :videos
    get 'videos/show/:youtube_id', :to => 'videos#show', :as => :video
    get 'videos/page/:videos_page', :to => 'videos#index'
    resources :videos

  end

  #
  # old legacy stuff
  #
  get 'google4b2e82b4dbbf505d', :to => 'utils/verification#one'
  get 'index.php/events/calendar/*everything' => redirect { |params, request| '/' }
  get 'index.php/events/view/*everything' => redirect { |params, request| '/' }
  get 'index.php/events/in/:cityname' => redirect { |params, request| "/cities/travel-to/#{params[:cityname]}" }
  get 'index.php' => redirect { |params, request| '/' }
  match 'venue_types/*everything' => redirect { |params, request| '/' }
  match 'venue_types' => redirect { |params, request| '/' }
  match 'dictionaryitems/*everything' => redirect { |params, request| '/' }
  match 'dictionaryitems' => redirect { |params, request| '/' }
  match 'helps/*everything' => redirect { |params, request| '/' }
  match 'helps' => redirect { |params, request| '/' }
  match 'events/*everything' => redirect { |params, request| '/' }
  match 'events' => redirect { |params, request| '/' }

  # add scope
  match '*other' => redirect { |params, request| "/en/#{params[:other]}" }

end
