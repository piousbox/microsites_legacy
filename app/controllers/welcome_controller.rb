
class WelcomeController < ApplicationController
  
  def set_city
    next_cityname = params[:user][:cityname]
    city = City.where( :cityname => next_cityname ).first
    unless current_user.blank?
      current_user.current_city = city
      current_user.save
    end
    redirect_to request.referrer
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
      redirect_to :controller => :users, :action => :organizer

    when 'cac.local', 'computationalartscorp.com'
      redirect_to :controller => :cac, :action => :home
    
    when 'piousbox.com', 'pi.local'
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

  def help
    ;
  end
  
end



