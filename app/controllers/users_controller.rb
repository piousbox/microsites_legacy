

class UsersController < ApplicationController
  
  load_and_authorize_resource :unless => proc { Rails.env.test? }
  
  def resume
    @user = User.where( :username => params[:username] ).first
    
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
    render :layout => 'organizer'
  end
  
  def index
    render :layout => 'application'
  end
  
  def organizer
    render 'layout' => 'organizer'
  end
  
  def sign_in
    render :layout => 'application'
  end
  
  def photos
    @photos = Photo.where( :user_id => current_user.id ).page( params[:photos_page] )
  end
  
end