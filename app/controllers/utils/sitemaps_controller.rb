class Utils::SitemapsController < ApplicationController
  skip_authorization_check

  def sitemap
    @reports = Report.all.where( :site => @site, :is_trash => false, :is_public => true )
    @galleries = Gallery.all.where( :site => @site, :is_trash => false, :is_public => true )
    @users = []

    case @domain
    when 'pi.local', 'piousbox.com'
      pi_sitemap
    else
      default_sitemap
    end

    respond_to do |format|
      format.xml do
        headers['Content-Type'] = 'application/xml'
        render 'utils/sitemap', :layout => false
      end
      format.json do
        json = {
          :reports => @reports.to_a.each { |r| r['site_name'] = r.site.domain },
          :galleries => @galleries.to_a.each { |r| r['site_name'] = r.site.domain },
          :users => @users
        }
        render :json => json
      end
    end
  end

  private

  def pi_sitemap
    @users = User.all
    @meta = [
      { :url => site_path(@site.domain) },
      { :url => about_path }
    ]
  end

  def default_sitemap
    @meta = []
  end

end

