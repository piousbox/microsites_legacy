class WelcomeController < ApplicationController
  skip_authorization_check
  before_filter :load_features

  caches_page :help, :about, :privacy

  def set_city
    next_cityname = params[:user][:cityname]
    city = City.where( :cityname => next_cityname ).first
    if city.blank?
      session[:current_city] = nil
    else
      session[:current_city] = {
        :name => city['name_'+@locale.to_s],
        :cityname => city.cityname
      }
    end
    unless current_user.blank?
      current_user.current_city = city
      current_user.save
      flash[:notice] = 'Current city set.'
    else
      flash[:notice] = 'Current city set. Login to save your selection & customize other features of this website.'
    end
    redirect_to request.referrer
  end

  def home
    case @domain
    when 'organizer.local', 'organizer.annesque.com', 'qxt.local', 'annesque.com'
      redirect_to :controller => :users, :action => :organizer

    else
      redirect_to :controller => :sites, :action => :show, :domainname => @domain
    end
  end

  def help
    ;
  end

  def about
    ;
  end

  def privacy
    ;
  end
  
end
