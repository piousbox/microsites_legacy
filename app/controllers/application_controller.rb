require 'string'
require 'float'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_defaults

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
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale  : nil
  end
  
  # Get locale code from request subdomain (like http://it.application.local:3000)
  #   127.0.0.1 gr.application.local
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first || 'en'
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : :en
  end

  def extract_layout_from_subdomain
    if request.host.split('.').include? 'm'
      @layout = 'organizer'
    else
      @layout = params[:layout] || 'application'
    end
  end

  def default_url_options(options={})
    options[:locale] = I18n.locale || I18n.default_locale
    # options[:layout] = @layout || 'application'
    options
  end
  
  def set_defaults
    # I18n.locale = extract_locale_from_tld || I18n.default_locale
    # @locale = I18n.locale = params[:locale] || I18n.default_locale
    # @locale = I18n.locale = extract_locale_from_subdomain
    @locale = I18n.locale = params[:locale] || 'en'

    @layout = extract_layout_from_subdomain

    @domain = request.domain
    @site = Site.where( :domain => @domain, :lang => @locale ).first

    @action_name = params[:controller].gsub('/', '_') + '_' + params[:action]
    @action_classes = "#{params[:controller].gsub('/', '_')} #{params[:action]}" # #{@locale}
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
  
end

#class ActionMailer::Base
#  def default_url_options options = {}
#    options[:locale] ||= 'en'
#    options[:host] ||= 'piousbox.com'
#    return options
#  end
#end
