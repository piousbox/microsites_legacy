class Utils::SitemapsController < ApplicationController
  skip_authorization_check

  def sitemap
    @reports = Report.all.where( :site => @site, :is_trash => false, :is_public => true )
    @galleries = Gallery.all.where( :site => @site, :is_trash => false, :is_public => true )
    @videos = []
    @tags = []
    @cities = []
    @venues = []
    @users = []

    case @domain
    when 'cac.local', 'computationalartscorp.com'
      cac_sitemap
    when 'pi.local', 'piousbox.com'
      pi_sitemap
    when 'travel-guide.mobi', 'staging.travel-guidel.mobi', 'mobi.local'
      travel_guide_sitemap
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
          :cities => @cities,
          :reports => @reports.to_a.each { |r| r['site_name'] = r.site.domain },
          :galleries => @galleries.to_a.each { |r| r['site_name'] = r.site.domain },
          :users => @users,
          :venues => @venues,
          :videos => @videos,
          :tags => @tags
        }
        render :json => json
      end
    end
  end

  private

  def pi_sitemap
    @users = User.all
    @tags = Tag.all
    @meta = [
      { :url => site_path(@site.domain) },
      { :url => about_path },
      { :url => privacy_path }
    ]
  end

  def travel_guide_sitemap
    @cities = City.all
    @venues = Venue.all
    @meta = [
      { :url => site_path(@site.domain) },
      { :url => cities_path }
    ]
  end

  def bss_sitemap
    meta = []
  end

  def cac_sitemap
    paths = [
             '/',
             '/news',
             '/contact',
             '/services',
             '/portfolio',
             '/about-us',
             '/team'
            ]
    @meta = paths.map do |p|
      { :url => p }
    end
  end

end

