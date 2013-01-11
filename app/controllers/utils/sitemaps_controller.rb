

class Utils::SitemapsController < ApplicationController

  layout nil

  def sitemap
    headers['Content-Type'] = 'application/xml'
    
    case @domain
    when 'cac.local', 'computationalartscorp.com'
      cac_sitemap
    when 'piousbox.com', 'pi.local'
      pi_sitemap
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

    @urls = []
    paths.each do |p|
      @urls << { :path => p }
    end

    @urls.each do |u|
      if u[:last_modified].blank?
        u[:last_modified] = Time.now
      end
    end

    respond_to do |format|
      format.xml do
        render 'utils/simple_sitemap'
      end
    end

    return
  end

  def pi_sitemap
    travel = Tag.where( :name_seo => 'travel' ).first
    @reports = [] # Report.all.fresh.where( :tag => travel )
    @users = [] # User.all.fresh
    @galleries = Gallery.all.fresh.where( :tag => travel )
    @tags = Tag.all.fresh # []
    @cities = City.all # []
    @venues = Venue.all.fresh.public # []

    @meta = [
      { :url => '/' },
      { :url => '/about' },
      { :url => '/privacy' }
    ]

  end

  def ish_sitemap
    ;
  end

  def mobi_sitemap
    ;
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

  
end

