require 'string'
require 'float'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_defaults
  before_filter :set_lists, :only => [ :new, :create, :update, :edit ]
  before_filter :set_new_for_organizer

  include ActionController::Caching::Sweeping
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to sign_in_path, :notice => t('users.please_sign_in')
  end

  check_authorization

  private
  
  def after_sign_in_path_for resource
    organizer_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for resource
    organizer_path
  end
  
  def puts! arg
    unless Rails.env.production?
      puts '+++ +++'
      puts arg.inspect
    end
  end
  
  # Get locale from top-level domain or return nil if such locale is not available
  # You have to put something like:
  #   127.0.0.1 application.com
  #   127.0.0.1 application.it
  #   127.0.0.1 application.pl
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end
  
  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  #   127.0.0.1 gr.application.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first || 'en'
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : :en
  end
  
  def default_url_options(options={})
    # options[:locale] = I18n.locale
    options[:layout] = @layout || 'application'
    options
  end
  
  def set_lists
    @cities = City.list
    @tags = Tag.all.list
    unless current_user.blank?
      @galleries = Gallery.where( :user => current_user ).list
      @reports = Report.where( :user => current_user ).list
    end    
  end
  
  def set_defaults
    # I18n.locale = extract_locale_from_tld || I18n.default_locale
    # @locale = I18n.locale = params[:locale] || I18n.default_locale
    @locale = I18n.locale = extract_locale_from_subdomain

    @domain = request.host
    puts! @domain
    @site = Site.where( :domain => @domain, :lang => @locale ).first

    @display_ads = true
    @display_help = true

    if user_signed_in?
      @current_user = current_user || session['current_user']
      @display_ads = @current_user.display_ads
      @display_help = @current_user.display_help
      if session[:current_city].blank?
        unless @current_user.current_city.blank?
          session[:current_city] = {
            :name => @current_user.current_city['name_'+@locale.to_s],
            :cityname => @current_user.current_city.cityname
          }
        end
      end
    end
    
    unless session[:current_city].blank?
      @current_city = City.where( :cityname => session[:current_city][:cityname] ).first
    end

    @action_name = params[:controller].gsub('/', '_') + '_' + params[:action]
    @action_classes = "#{params[:controller].gsub('/', '_')} #{params[:action]}" # #{@locale}
    
    @list_citynames = City.where( :is_feature => true ).list_citynames @locale.to_s
    @layout = params[:layout] || 'application'      

    @parent_tags = Tag.all.where( :parent_tag => nil )
  end

  def load_features args = {}
    @newsitems = []

    if args[:cityname].blank?
      features = YAML.load_file("#{Rails.root}/config/features.yml")
    else
      features = YAML.load_file("#{Rails.root}/config/#{args[:cityname]}_features.yml")
    end
    @features = []
    features.each do |f|
      @features << f.symbolize_keys
    end
  end

  def set_new_for_organizer
    @addressbookitem = Addressbookitem.new
    @cities_user = CitiesUser.new
  end
  
end
