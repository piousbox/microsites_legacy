

class WelcomeController < ApplicationController
  
  before_filter :set_defaults, :only => [ :homepage ]
  
  
  
  def homepage
    @main_tag = Tag.where( :domain => @domain ).first
    
  end
  
  
  
  private
  
  def set_defaults
    @domain = request.host
    
  end

end