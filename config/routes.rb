Microsites2::Application.routes.draw do

  root :to => 'welcome#home'

  # then it just disappears...
  # get "/ru/reports/view/Explanation_Of_Symbolic_Links" => redirect { |params, request| "http://piousbox.com/en/users/show/piousbox" }
  
  scope "/:locale", :constraints => { :locale => /en|ru|pt/ } do

    root :to => 'welcome#home'
    get 'about', :to => 'welcome#about', :as => :about
    post 'set_city', :to => 'welcome#set_city', :as => :set_city
    get 'privacy', :to => 'welcome#privacy', :as => :privacy
    get 'contact', :to => 'welcome#contact', :as => :contact
    
    devise_for :users, :controllers => {
      :sessions => "users/sessions",
      :registrations => 'users/registrations'
    }

    get "sites/:domainname.html/newsitems/page/:newsitems_page" => redirect { |params, request|
      "/#{params[:locale]}/sites/#{params[:domainname]}/newsitems/page/#{params[:newsitems_page]}" 
    }, :constraints => { :domainname => /.*/, :format => /xml|html|json/ }
    get "sites/:domainname.html", :to => "sites#show", :as => :site,   :constraints => { :domainname => /.*/, :format => /xml|html|json/ }
    get 'sites/:domainname/tags', :to => 'tags#index', :as => :tags,   :constraints => { :domainname => /.*/, :format => /xml|html|json/ }
    get 'sites/:domainname/tags/page/:tags_page', :to => 'tags#index', :constraints => { :domainname => /.*/, :format => /xml|html|json/ }
    scope 'sites/:domainname',                         :as => :sites,  :constraints => { :domainname => /.*/, :format => /xml|html|json/ } do
      get 'features', :to => 'sites#features', :as => :features
      get 'features/page/:features_page', :to => 'sites#features'
      get 'newsitems/page/:newsitems_page', :to => 'sites#show'
      get 'newspage/:newsitems_page' => redirect { |p,r| "/#{p[:locale]}/sites/#{p[:domainname]}/newsitems/page/#{p[:newsitems_page]}" }

      get 'reports', :to => 'reports#index', :as => :reports
      get 'reports/page/:reports_page', :to => 'reports#index'

      get 'galleries', :to => 'galleries#index', :as => :galleries
      get 'galleries/page/:galleries_page', :to => 'galleries#index'

      get 'sitemap' => redirect { |params, request| "http://#{request.domain}/en/sitemap.xml" }
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
    get 'galleries/j_show/:id', :to => 'galleries#j_show', :as => :j_gallery, :defaults => { :format => :json }
    get 'galleries/:style/:galleryname', :to => 'galleries#show', :as => :gallery_show_style, :constraints => { :style => /show_long|show_mini|show/ }
    get 'galleries/:id/edit', :to => 'galleries#edit', :as => :edit_gallery
    post 'galleries/:id', :to => 'galleries#update', :as => :update_gallery
    post 'galleries', :to => 'galleries#create'
    get 'galleries/:galleryname/multiadd', :to => 'photos#multinew', :as => :gallery_multiadd_photos
    post 'galleries/:galleryname/multiadd', :to => 'photos#j_create', :as => :gallery_multiadd_photos, :defaults => { :format => :json }
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
    get '/users/:username/resume/print', :to => 'users#show', :defaults => { :print => true }, :as => :user_resume_print
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
    match '/users/new_message', :to => 'users#new_message', :as => :new_message
    # resources :user_profile
    # messages are not a full resource yet.

    get 'tags' => redirect { |params, request| "/#{params[:locale]}/sites/#{request.domain}/tags" }
    get 'tags/:tagname' => redirect { |params, request| "/#{params[:locale]}/tags/view/#{params[:tagname]}" }
    get 'tags/view/:tagname', :to => 'tags#show', :as => :tag

    get 'v', :to => 'utils/utils#version', :as => :version
    get 'sitemap', :to => 'utils/sitemaps#sitemap', :as => :sitemap

    get 'videos', :to => 'videos#index', :as => :videos
    get 'videos/page/:videos_page', :to => 'videos#index'
    get 'videos/show/:youtube_id', :to => 'videos#show', :as => :video
    get 'videos/view/:youtube_id' => redirect { |p,r| "/#{p[:locale]}/videos/show/#{p[:youtube_id]}" }
    post 'videos', :to => 'videos#create'
    get 'videos/new', :to => 'videos#new', :as => :new_video
    # resources :videos

    #
    # redirects
    #
    # cities
    get 'cities/travel-to/:cityname' => redirect { |params, request| "http://travel-guide.mobi/en/cities/travel-to/#{params[:cityname]}" }
    get 'cities' => redirect { |params, request| 'http://travel-guide.mobi/en/cities' }
    get 'cities/*bbb' => redirect { |params, request| "http://travel-guide.mobi/#{params[:locale]}/cities/#{params[:bbb]}" }
    get 'venues/in-city/:cityname' => redirect { |params, request| "http://travel-guide.mobi/en/cities/travel-to/#{params[:cityname]}" }
    #
    # venues
    get 'venues/in-city/:cityname' => redirect { |p,r| "http://travel-guide.mobi/#{p[:locale]}/cities/travel-to/#{p[:cityname]}" }
    get 'venues/show/:venue_name' => redirect { |p, r| "http://travel-guide.mobi/#{p[:locale]}/venues/show/#{p[:venue_name]}" }
    get 'venues/*bbb' => redirect { |p, r| "http://travel-guide.mobi/#{p[:locale]}/venues/#{p[:bbb]}" }

    #
    # other
    match '*other', :to => 'welcome#error500', :as => :error500

  end # scope :locale
  
  get 'search', :to => 'welcome#search'
 
  scope 'spec_runner', :as => :spec_runner do
    root :to => 'spec_runner#all'
    get ':which', :to => 'spec_runner#which', :as => :which
  end

  get 'sitemap_photos', :to => 'utils/sitemaps#photos', :as => :sitemap_photos

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

  # this is one hop instead of two (but there is code publication)
  get 'tags' => redirect { |params, request| "/en/sites/#{request.domain}/tags" }

  # add scope
  match '*other' => redirect { |params, request| "/en/#{params[:other]}" }

end
