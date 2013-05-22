
class Manager::ManagerController < ApplicationController
  
  before_filter :require_manager
  before_filter :set_n
  before_filter :sett_lists

  layout 'manager'

  skip_authorization_check

  protected
  
  def require_manager
    authenticate_or_request_with_http_basic do |username, password|
      if @current_user.blank?
        redirect_to new_user_session_path
      else
        username == 'piousbox' && password == 'sho3b0x3' && ( @current_user.username == 'piousbox' || @current_user.username == 'manager' )
      end
    end
  end

  def set_n
    @n_reports = Report.all.length
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
    @users_list = User.list
    @list_venues = Venue.list
    @reports_list = Report.all.list
    @galleries_list = Gallery.all.list
  end

  def setup_defaults
    @user = 'ubuntu'
    @chef_workdir = "/home/piousbox/projects/rails-quick-start"
    @keys = [ "/home/piousbox/projects/rails-quick-start/rails-quick-start.pem" ]
    
    @nodes = JSON.parse(File.read( "#{@chef_workdir}/data_bags/utils/port_forward.json" ))
    @nodes = @nodes['port_forwards']
    @nodes.map! do |item|
      item = item.merge( { :host => 'staging.piousbox.com' } )
      item.symbolize_keys
    end
    puts! @nodes
    @nodes_trash = [
              { :node_name => 'db_micro_1', :port => '2290', :host => 'infiniteshelter.com' },
              { :node_name => 'app_server_8', :port => '2292', :host => 'infiniteshelter.com' },
              { :node_name => 'load_balancer_micro', :port => '22', :host => 'infiniteshelter.com' },
              { :node_name => 'load_balancer_staging', :port => '22', :host => 'staging.piousbox.com' },
              { :node_name => 'app_server_9', :port => '2293', :host => 'infiniteshelter.com' },
              { :node_name => 'app_server_12', :port => '2296', :host => 'staging.piousbox.com' },
              { :node_name => 'app_server_11', :port => '2294', :host => 'staging.piousbox.com' },
              { :node_name => 'util_micro_1', :port => '2223', :host => 'infiniteshelter.com' }
    ]

    @apps = [
      { :id => 'microsites2' },
      { :id => 'sample-python-app' },
      { :id => 'sample-java-app' }
    ]

  end

  
end
