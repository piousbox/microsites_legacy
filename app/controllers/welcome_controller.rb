

class WelcomeController < ApplicationController

  load_and_authorize_resource

  def set_locale
    ;
  end

  def ish_home
    ;
  end

  def privacy
    if cac_domains.include? @domain
      render :action => :privacy, :controller => :cac
    else
      ; # generic privacy
    end
  end

  def home

    #
    # finance
    #
    # upload photos
    #

    if cac_domains.include? @domain
      redirect_to :controller => :cac, :action => :home
    elsif qxt_domains.include? @domain
      redirect_to :controller => :users, :action => :organizer
    elsif mobi_domains.include? @domain
      redirect_to :controller => :travel, :action => :home
    else
      case @domain
      when 'ish.local', 'infiniteshelter.com'
        # redirect_to :controller => :ish, :action => :home
        # redirect_to :action => :ish_home
        redirect_to :controller => :travel, :action => :home
    
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

  private

  def cac_domains
    [ 'cac.local', 'computationalartscorp.com' ]
  end

  def mobi_domains
    [ 'mobi.local', 'travel-guide.mobi' ]
  end
  
  def qxt_domains
    [ 'organizer.local', 'organizer.annesque.com', 'qxt.local' ]
  end
  
end



