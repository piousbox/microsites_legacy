

class UsersController < ApplicationController
  
  load_and_authorize_resource
  
  # caches_page :resume
  # cache_sweeper :user_sweeper
  
  def resume
    @user = User.where( :username => params[:username] ).first
    @profile = UserProfile.where( :user => @user, :lang => params[:locale] ).first
    
    authorize! :resume, @user
    
    if params[:print]
      render :print, :layout => 'print'
    else
      render :layout => 'resume'
    end
    
  end
  
  def galleries
    
    @user = User.where( :username => params[:username] ).first
    authorize! :galleries, @user
    
    # render :layout => 'pi'
    render :layout => 'resume'
  end
  
  def reports
    
    @user = User.where( :username => params[:username] ).first
    authorize! :reports, @user
    
    # render :layout => 'pi'
    render :layout => 'resume'
  end
  
  def account
    authorize! :account, User.new
    render :layout => 'organizer'
  end
  
  def index
    @title = 'All Users'
    @users = User.all
    render
  end
  
  def organizer
    authorize! :organizer, User.new
    @reports = Report.where( :user => (current_user || session['current_user']) ).page(1)
    render :layout => 'organizer'
  end
  
  # these are _my_ photos
  def photos
    authorize! :photos, User.new
    @photos = Photo.where( :user => (current_user || session['current_user']) ).page( params[:photos_page] )
    render :layout => 'organizer'
  end
  
end