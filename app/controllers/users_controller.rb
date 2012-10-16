

class UsersController < ApplicationController
  
  load_and_authorize_resource :unless => proc { Rails.env.test? }
  
  layout 'organizer'
  
  caches_page :resume
  cache_sweeper :user_sweeper
  
  def resume
    @user = User.where( :username => params[:username] ).first
    @profile = UserProfile.where( :user => @user, :lang => params[:locale] ).first
    
    # render :layout => 'pi'
    render :layout => 'resume'
  end
  
  def galleries
    @user = User.where( :username => params[:username] ).first
    
    # render :layout => 'pi'
    render :layout => 'resume'
  end
  
  def reports
    @user = User.where( :username => params[:username] ).first
    
    # render :layout => 'pi'
    render :layout => 'resume'
  end
  
  def account
    # render :layout => 'organizer'
  end
  
  def index
    @title = 'All Users'
    @users = User.all
    render :layout => 'resume'
  end
  
  def organizer
    @reports = Report.where( :user => (current_user || session['current_user']) ).page(1)
    # render 'layout' => 'organizer'
  end
  
  def photos
    @photos = Photo.where( :user => (current_user || session['current_user']) ).page( params[:photos_page] )
    # render 'layout' => 'organizer'
  end
  
end