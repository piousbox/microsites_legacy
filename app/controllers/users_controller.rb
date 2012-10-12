

class UsersController < ApplicationController
  
  load_and_authorize_resource :unless => proc { Rails.env.test? }
  
  layout 'organizer'
  
  def resume
    render :layout => 'pi'
  end
  
  def account
    ;
  end
  
  def organizer
    ;
  end
  
  def sign_in
    render :layout => 'application'
  end
  
  def photos
    @photos = Photo.where( :user_id => current_user.id ).page( params[:photos_page] )
  end
  
end