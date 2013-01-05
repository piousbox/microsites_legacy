
class WelcomeController < ApplicationController

  before_filter :redirect_to_pi, :only => [ :home ]

  def set_locale
    ;
  end

  def ish_home
    ;
  end

  def privacy
    case @domain
    when 'cac.local', 'computationalartscorp.com'
      render :action => :privacy, :controller => :cac
    else
      ;
    end
  end

  def home
    
    case @domain
    when 'organizer.local', 'organizer.annesque.com', 'qxt.local'
      # qxt
      redirect_to :controller => :users, :action => :organizer
      
    when 'mobi.local', 'travel-guide.mobi'
      # travel mobi
      redirect_to :controller => :travel, :action => :home
      
    when 'ish.local', 'infiniteshelter.com'
      # redirect_to :controller => :ish, :action => :home
      # redirect_to :action => :ish_home
      redirect_to :controller => :travel, :action => :home
    
    when 'cac.local', 'computationalartscorp.com'
      # cac
      redirect_to :controller => :cac, :action => :home
    
    when 'piousbox.com', 'pi.local'
      # pi resume
      redirect_to :controller => :travel, :action => :home
      # redirect_to :controller => :users, :action => :show, :username => 'piousbox'
      
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



