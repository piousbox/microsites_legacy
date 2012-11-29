

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

    @urls.each do |u|
      if u[:last_modified].blank?
        u[:last_modified] = Time.now
      end
    end
    
    respond_to do |format|
      format.xml do
        render 'utils/sitemap'
      end
    end
    
    
  end

  private

  def cac
    @urls = [
      { :path => '/news' }
    ]
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
    ;
  end

  
end

