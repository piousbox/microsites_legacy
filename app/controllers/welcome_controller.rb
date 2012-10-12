

class WelcomeController < ApplicationController
  

  def home
    
    case @domain
      
    when 'organizer.local'
      redirect_to :controller => :users, :action => :organizer
    when 'organizer.annesque.com'
      redirect_to :controller => :users, :action => :organizer
      
    when 'travel.local'
      redirect_to :controller => :travel, :action => :home
    when 'travel-guide.mobi'
      redirect_to :controller => :travel, :action => :home
      
    when 'ish.local'
      redirect_to :controller => :ish, :action => :home
    when 'infiniteshelter.com'
      redirect_to :controller => :ish, :action => :home
      
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
        redirect_to :controller => :blog, :action => :home
        
      else
        render 
        
      end
      
    end
    
  end

  
end



