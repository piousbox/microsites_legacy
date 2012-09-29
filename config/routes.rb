Microsites2::Application.routes.draw do
  

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root :to => 'welcome#homepage'
  
  get 'about', :to => 'welcome#about', :as => :about
  
end
