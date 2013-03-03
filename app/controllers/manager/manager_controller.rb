
class Manager::ManagerController < ApplicationController
  
  before_filter :require_manager
  
  layout 'manager'

  skip_authorization_check

  before_filter :set_n

  ##
  ## protected begin
  ##
  protected
  
  def require_manager
    if @current_user.blank?
      flash[:notice] = 'Please login to use manager.'
      redirect_to sign_in_path
    else
      unless 'test' == Rails.env
        authenticate_or_request_with_http_basic do |username, password|
          username == 'piousbox' && password == 'sho3b0x'
        end
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
      {
        :node_name => 'db_micro_1',
        :port => '2290'
      },
      {
        :node_name => 'app_server_8',
        :port => '2292'
      },
      {
        :node_name => 'load_balancer_micro',
        :port => '22'
      }
    ]

    @apps = [
      { :id => 'showv-cakephp' },
      { :id => 'microsites2' },
      { :id => 'travel-guide' },
      { :id => 'piousbox-resume' },
      { :id => 'sample-python-app' },
      { :id => 'sample-java-app' }
    ]
    
  end

  private

  def sett_lists
    @cities = City.list
    @tags = Tag.list
    @list_venues = Venue.list
  end
  
end
