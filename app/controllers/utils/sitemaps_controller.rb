class Utils::SitemapsController < ApplicationController
  skip_authorization_check

  def sitemap
    @reports = Report.all.where( :site => @site )
    @galleries = Gallery.all.where( :site => @site )
    @users = User.all
    @tags = Tag.all

    @meta = [
      { :url => site_path(@site.domain) },
      { :url => about_path }
    ]

    respond_to do |format|
      format.xml do
        headers['Content-Type'] = 'application/xml'
        render 'utils/sitemap', :layout => false
      end
      format.json do
        json = {
          :reports => @reports.to_a.each { |r| r['site_name'] = r.site.domain },
          :galleries => @galleries.to_a.each { |r| r['site_name'] = r.site.domain },
          :users => @users,
          :tags => @tags
        }
        render :json => json
      end
    end
  end

  def photos
    @galleries = Gallery.all.where( :site => @site )
    respond_to do |format|
      format.xml do
        headers['Content-Type'] = 'application/xml'
        render 'utils/sitemap_photos', :layout => false
      end
    end
  end
  
end

