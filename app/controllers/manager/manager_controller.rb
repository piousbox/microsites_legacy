
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
    sedux = Tag.where( :name_seo => 'sedux' ).first
    @n_sedux_reports = Report.where( :tag => sedux ).length
    @n_sedux_galleries = Gallery.where( :tag => sedux ).length

    webdevzine = Tag.where( :name_seo => 'webdevzine' ).first
    @n_webdevzine_reports = Report.where( :tag => webdevzine ).length
    @n_webdevzine_galleries = Gallery.where( :tag => webdevzine ).length

    travel = Tag.where( :name_seo => 'travel' ).first
    @n_travel_reports = Report.all.where( :tag => travel ).length
    @n_travel_galleries = Gallery.all.where( :tag => travel ).length

    pi = Tag.where( :name_seo => 'piousbox' ).first
    @n_pi_reports = Report.all.where( :tag => pi ).length
    @n_pi_galleries = Gallery.all.where( :tag => pi ).length

    @n_reports = Report.all.length
    @n_tags = Tag.all.length
    @n_galleries = Gallery.all.length
    @n_photos = Photo.all.length
    @n_sites = Site.all.length
    @n_users = User.all.length
    @n_cities = City.all.length
    @n_venues = Venue.all.length
    @n_videos = Video.all.length
    
    cac = Tag.where( :name_seo => 'cac' ).first
    @n_cac_reports = Report.all.where( :tag => cac ).length
    @n_cac_galleries = Gallery.all.where( :tag => cac ).length

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
  
end
