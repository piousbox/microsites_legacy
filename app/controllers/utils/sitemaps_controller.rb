
class Utils::SitemapsController < ApplicationController

  layout nil

  before_filter :set_pfft

  skip_authorization_check

  def sitemap
    headers['Content-Type'] = 'application/xml'
    
    case @domain
    when 'cac.local', 'computationalartscorp.com', 'blog.computationalartscorp.com'
      cac_sitemap

    when 'piousbox.com', 'pi.local'
      pi_sitemap

    when 'blog.sedux.local', 'blog.sedux.net'
      sedux_sitemap
      
    when 'blog.webdevzine.com', 'blog.webdevzine.local'
      webdevzine_sitemap

    else
      default_sitemap
      
    end

    respond_to do |format|
      format.xml do
        render 'utils/sitemap'
      end
    end
  end

  ##
  ## private starts
  ##
  private

  def pi_sitemap
    @reports = Report.all
    @galleries = Gallery.all

    @users = User.all
    @tags = Tag.all
    @cities = City.all
    @venues = Venue.all

    @meta = [
      { :url => '/' },
      { :url => '/about' },
      { :url => '/privacy' }
    ]

  end

  def default_sitemap
    @reports = Report.all
    @galleries = Gallery.all
    @cities = City.all
    @countries = Country.all
    @tags = Tag.all
    @venues = Venue.all
    @users = User.all
  end

  def webdevzine_sitemap
    tag = Tag.where( :domain => 'blog.webdevzine.com' ).first
    @reports = Report.all.where( :tag => tag )
    @galleries = Gallery.all.where( :tag => tag )
  end

  def qxt_sitemap
    meta = []
  end

  def travel_sitemap
    meta = []
  end

  def ish_sitemap
    meta = []
  end

  def sedux_sitemap
    
    tag = Tag.where( :domain => 'blog.sedux.net' ).first
    @reports = Report.all.where( :tag => tag )
    @galleries = Gallery.all.where( :tag => tag )
    
  end

  def bss_sitemap
    meta = []
  end

  def processing_sitemap
    meta = []
  end

  def cac_sitemap
    tag = Tag.where( :name_seo => 'cac' ).first
    @reports = Report.all.where( :tag => tag )
    @galleries = Gallery.all.where( :tag => tag )

    paths = [
      '/',
      '/news',
      '/contact',
      '/services',
      '/portfolio',
      '/about-us',
      '/team'
    ]

    @urls = []
    paths.each do |p|
      @urls << { :path => p }
    end

    @urls.each do |u|
      if u[:last_modified].blank?
        u[:last_modified] = Time.now
      end
    end

  end

  private

  def set_pfft
    @cities = []
    @venues = []
    @reports = []
    @galleries = []
    @users = []
    @tags = []
    
  end

end

