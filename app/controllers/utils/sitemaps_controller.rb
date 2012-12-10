

class Utils::SitemapsController < ApplicationController

  layout nil

  def sitemap
    headers['Content-Type'] = 'application/xml'
    
    case @domain
    when 'cac.local', 'computationalartscorp.com'
      cac
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

  def cac
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

  def pi
    ;
  end

  def ish
    ;
  end

  def mobi
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

