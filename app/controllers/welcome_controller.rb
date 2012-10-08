
require 'string'

class WelcomeController < ApplicationController
  

  def home
    
    case @domain
    when 'cac.local'
      redirect_to :controller => :cac, :action => :home
      
    when 'computationalartscorp.com'
      redirect_to :controller => :cac, :action => :home
      
    when 'piousbox.local'
      redirect_to :controller => :users, :action => :resume, :username => 'piousbox'
      
    when 'piousbox.com'
      redirect_to :controller => :users, :action => :resume, :username => 'piousbox'
      
    else
      if @domain.include? 'blog'
        @reports = Report.for_homepage :main_tag => @main_tag,
          :page => params[:page]
    
        render :action => :blog_home
        
      else
        render :layout => false
        
      end
      
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



