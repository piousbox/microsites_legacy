class Manager::ManagerController < ApplicationController
  
  before_filter :require_manager
  before_filter :set_n
  before_filter :sett_lists

  layout 'manager'

  skip_authorization_check

  protected
  
  def require_manager
    if Rails.env.test?
      return
    else
      authenticate_or_request_with_http_basic do |username, password|
        username == 'piousbox' && password == 'sho3b0x3' && ( current_user.username == 'piousbox' || current_user.username == 'manager' )
      end       
    end
  end

  def set_n
    @n_reports = Report.all.where( :lang => @locale ).length
    @n_tags = Tag.all.length
    @n_galleries = Gallery.all.length
    @n_photos = Photo.all.length
    @n_sites = Site.all.length
    @n_users = User.all.length
    @n_cities = City.all.length
    @n_venues = Venue.all.length
    @n_videos = Video.all.length    
  end

  def sett_lists
    @cities = City.list
    @tags = Tag.list
    @tags_list = Tag.list
    @sites_list = Site.list
    @users_list = User.list
    @list_venues = Venue.list
    @reports_list = Report.all.list
    @galleries_list = Gallery.all.list
  end

  def setup_defaults
    return if Rails.env.production?
    @user = 'ubuntu'
    @chef_workdir = "/home/piousbox/projects/rails-quick-start"
    @keys = [ "/home/piousbox/projects/rails-quick-start/rails-quick-start.pem" ]
    
    @nodes = JSON.parse(File.read( "#{@chef_workdir}/data_bags/utils/port_forward.json" ))
    @nodes = @nodes['port_forwards']
    @nodes.map! do |item|
      item = item.merge( { :host => 'staging.piousbox.com' } )
      item.symbolize_keys
    end

    @nodes = @nodes + [{ :host => 'staging.piousbox.com', :port => '22', :node_name => 'load_balancer_staging' },
                       { :host => 'piousbox.com', :port => '22', :node_name => 'load_balancer_micro' }]

    # @domains = JSON.parse(File.read("#{@chef_workdir}/data_bags/utils/sites.json"))
    # @domains = @domains['domains']
    
  end

  
end
