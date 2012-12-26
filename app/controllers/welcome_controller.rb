

class WelcomeController < ApplicationController

  load_and_authorize_resource

  def set_locale
    ;
  end

  def ish_home
    ;
  end

  def home

    # ftim
    #
    # finance
    #
    # upload photos
    #
    
    case @domain
    when 'organizer.local', 'organizer.annesque.com'
      # qxt
      redirect_to :controller => :users, :action => :organizer
      
    when 'mobi.local', 'travel-guide.mobi'
      # travel mobi
      redirect_to :controller => :travel, :action => :home
      
    when 'ish.local', 'infiniteshelter.com'
      # redirect_to :controller => :ish, :action => :home
      redirect_to :action => :ish_home
    
    when 'cac.local', 'computationalartscorp.com'
      # cac
      redirect_to :controller => :cac, :action => :home
    
    when 'piousbox.com', 'pi.local'
      # pi resume
      redirect_to :controller => :users, :action => :resume, :username => 'piousbox'
      
    else
      if @domain.include? 'blog'
        # sedux
        # webdevzine
        redirect_to :controller => :blog, :action => :home
        
      else
        render
        
      end
      
    end
    
  end

  
end



