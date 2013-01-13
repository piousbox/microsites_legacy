
class Utils::SitemapsController < ApplicationController

  layout nil

  before_filter :set_pfft

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

  private

  def pi_sitemap
    travel = Tag.where( :name_seo => 'travel' ).first
    @reports = Report.all.fresh.public.where( :tag => travel )
    @galleries = Gallery.all.fresh.public.where( :tag => travel )

    @users = User.all.fresh
    @tags = Tag.all.fresh
    @cities = City.all
    @venues = Venue.all.fresh.public

    @meta = [
      { :url => '/' },
      { :url => '/about' },
      { :url => '/privacy' }
    ]

  end

  def default_sitemap
    @reports = Report.all.fresh.public
    @galleries = Gallery.all.fresh.public
    @cities = City.all
    @countries = Country.all
    @tags = Tag.all.fresh.public
    @venues = Venue.all.fresh.public
    @users = User.all
  end

  def webdevzine_sitemap
    tag = Tag.where( :domain => 'blog.webdevzine.com' ).first
    @reports = Report.all.fresh.public.where( :tag => tag )
    @galleries = Gallery.all.fresh.public.where( :tag => tag )
    
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
    @reports = Report.all.fresh.public.where( :tag => tag )
    @galleries = Gallery.all.fresh.public.where( :tag => tag )
    
  end

  def bss_sitemap
    meta = []
  end

  def processing_sitemap
    meta = []
  end

  def cac_sitemap
    tag = Tag.where( :name_seo => 'cac' ).first
    @reports = Report.all.fresh.public.where( :tag => tag )
    @galleries = Gallery.all.fresh.public.where( :tag => tag )

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

