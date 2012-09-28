
class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_defaults
  
  private
  
  def set_defaults
    ;
  end
  
end
