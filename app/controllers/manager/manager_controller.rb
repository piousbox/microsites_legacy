
class Manager::ManagerController < ApplicationController
  
  before_filter :require_manager
  
  layout 'manager'

  load_and_authorize_resource

  before_filter :set_n

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
    sedux = Tag.where( :domain => 'blog.sedux.net' ).first
    @n_sedux_reports = Report.where( :tag => sedux ).length
    @n_sedux_galleries = Gallery.where( :tag => sedux ).length

    webdevzine = Tag.where( :domain => 'blog.webdevzine.com' ).first
    @n_webdevzine_reports = Report.where( :tag => webdevzine ).length

    @n_venues = Venue.all.fresh.length
    
  end
  
end