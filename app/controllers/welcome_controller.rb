
require 'string'

class WelcomeController < ApplicationController
  

  def home
    
    case @domain
    when 'piousbox.com'
    when 'piousbox.local'
      redirect_to :controller => :users, :action => :resume, :username => 'piousbox'
      
    else
      if @domain.include? 'blog'
        @reports = Report.for_homepage :main_tag => @main_tag,
          :page => params[:page]
    
        render :action => :blog_home
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



