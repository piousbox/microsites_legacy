

require 'string'

class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_defaults
  before_filter :set_action_name
  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to sign_in_path, :notice => t('users.please_sign_in')
  end
  
  private
  
  def puts! arg
    puts '+++ +++'
    puts arg.inspect
  end
  
  
  def set_defaults
    
    @domain = request.host
    @main_tag = Tag.where( :domain => @domain ).first
    @main_tag ||= Tag.new
    
    @tag_class = ''
    
    @tags = []
    
    if user_signed_in?
      @current_user = User.where( :email => current_user[:email] ).first
    end
    
    @cities = [ '', ''] + City.all.map do |c|
      [ c.name, c.id ]
    end
    
    @galleries = [ '', ''] + Gallery.all.map do |c|
      [ c.name, c.id ]
    end
    
  end
  
  
  def set_action_name
    begin
      @action_name = params[:controller].gsub('/', '_') + '_' + params[:action]
    rescue
    end
    
    begin
      @action_classes = params[:controller].gsub('/', '_')
    rescue
    end
    
  end
  
  
end
