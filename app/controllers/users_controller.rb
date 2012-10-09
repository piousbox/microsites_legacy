

class UsersController < ApplicationController
  
  load_and_authorize_resource :unless => proc { Rails.env.test? }
  
  def resume
    render :layout => 'pi'
  end
  
  def account
    ;
  end
  
  def organizer
    render :layout => 'organizer'
    
  end
  
  def sign_in
    ;
  end
  
end