

class WelcomeController < ApplicationController

  load_and_authorize_resource

  def set_locale
    
  end

  def home

    # ftim

    # sedux

    # travel mobi
    
    case @domain
    when 'organizer.local', 'organizer.annesque.com'
      redirect_to :controller => :users, :action => :organizer
      
    when 'mobi.local', 'travel-guide.mobi'
      redirect_to :controller => :travel, :action => :home
      
    when 'ish.local', 'infiniteshelter.com'
      redirect_to :controller => :ish, :action => :home
    
    when 'cac.local', 'computationalartscorp.com'
      redirect_to :controller => :cac, :action => :home
    
    when 'piousbox.com', 'pi.local'
      redirect_to :controller => :users, :action => :resume, :username => 'piousbox'
      
    else
      if @domain.include? 'blog'
        redirect_to :controller => :blog, :action => :home
        
      else
        render 
        
      end
      
    end
    
  end

  
end



