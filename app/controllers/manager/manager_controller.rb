
class Manager::ManagerController < ApplicationController
  
  before_filter :require_manager
  before_filter :set_n
  before_filter :sett_lists

  layout 'manager'

  skip_authorization_check

  ##
  ## protected begin
  ##
  protected
  
  def require_manager
    if @current_user.blank?
      flash[:notice] = 'Please login to use manager.'
      redirect_to sign_in_path
    else
      if 1 == @current_user[:group_id]
        unless 'test' == Rails.env
          authenticate_or_request_with_http_basic do |username, password|
            username == 'piousbox' && password == 'sho3b0x3'
          end
        end
      else
        return false
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
    
    @nodes = [
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

  def sett_lists
    @cities = City.list
    @tags = Tag.list
    @tags_list = Tag.list
    @list_venues = Venue.list
    @reports_list = Report.all.list
    @galleries_list = Gallery.all.list
  end
  
end
