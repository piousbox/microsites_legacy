

class WelcomeController < ApplicationController
  
  before_filter :set_defaults, :only => [ :homepage ]
  
  
  
  def homepage
    @main_tag = Tag.where( :domain => @domain ).first
    @reports = Report.where( :tag => @main_tag ).all
    @tags = Tag.where( :parent_tag => @main_tag).all
  end
  
  
  
  private
  
  def set_defaults
    @domain = request.host
    
  end

end