
class WelcomeController < ApplicationController
  skip_authorization_check
  before_filter :load_features

  # caches_page :homepage, :features, :newsitems
  
  def home
    redirect_to site_path( @domain )
  end

  def set_city
    next_city = params[:user][:city_id]
    city = City.find( next_city )
    if city.blank?
      session[:current_city] = nil
    else
      session[:current_city] = {
        :name => city['name_'+@locale.to_s],
        :cityname => city.cityname,
        :id => city.id
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

  def error500
    authorize! :error500, Manager.new
  end

  def search
    redirect_to "https://www.google.com/search?q=site:#{@domain}+#{params[:q]}&ie=utf-8&oe=utf-8"
  end

end
