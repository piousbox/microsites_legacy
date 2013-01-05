require 'string'

class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_defaults
  before_filter :set_lists, :only => [ :new, :create, :update, :edit ]
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to sign_in_path, :notice => t('users.please_sign_in')
  end
  
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
    parsed_locale = request.subdomains.first
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    options[:locale] = I18n.locale
    options[:is_mobile] = @is_mobile || '0'
    options
  end
  
  def set_lists
    @cities = City.list
    @tags = Tag.fresh.public.list
    @galleries = []
    @reports = []
    unless current_user.blank?
      @galleries = Gallery.where( :user => current_user ).list
      @reports = Report.where( :user => current_user ).list
    end
  end
  
  def set_defaults
    # I18n.locale = extract_locale_from_tld || I18n.default_locale
    @locale = I18n.locale = params[:locale] || I18n.default_locale

    @domain = request.host
    @site = Site.where( :domain => @domain ).first || Site.new

    @main_tag = Tag.where( :domain => @domain ).first || Tag.new
    @city ||= City.new
    @newsitems = @city.newsitems.order_by( :created_at => :desc ).limit(20) || []

    if user_signed_in?
      @current_user = current_user || session['current_user']
      cookies[:current_city] ||= @current_user.city
    end

    @action_name = params[:controller].gsub('/', '_') + '_' + params[:action]
    @action_classes = "#{params[:controller].gsub('/', '_')} #{params[:action]}" # #{@locale}
    
    @list_citynames = City.list_citynames

    
  end
  
end
