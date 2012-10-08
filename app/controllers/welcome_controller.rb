
require 'string'

class WelcomeController < ApplicationController
  

  def home
    
    if @domain.include? 'blog'
      @reports = Report.for_homepage :main_tag => @main_tag,
        :page => params[:page]
    
      render :action => :blog_home
    end
    
   
  end
  
  def about
    ;
  end
  
  def privacy
    ;
  end
  
  private
  
end



