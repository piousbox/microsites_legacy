
class SitesController < ApplicationController

  caches_page :show, self::CACHE_OPTIONS
  caches_page :features, self::CACHE_OPTIONS

  def show
    authorize! :show, Site.new

    if params[:site_id]
      @site = Site.find params[:site_id]
    end
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse
    @newsitems = @site.newsitems.all.order_by( :created_at => :desc ).page( params[:newsitems_page] ).per(@site.n_newsitems)
    
    @feature_tags = Tag.where( :parent_tag => nil, :site => @site ).order_by( :name => :desc )

    respond_to do |format|
      format.html do
        render
      end
      format.json do
        @newsitems.each do |n|
          if !n.report.blank?
            n['name'] = n.report.name
            n['url'] = url_for( :controller => 'reports', :action => 'show', :name_seo => n.report.name_seo )
          end
        end
        render :json => { :features => @features, :newsitems => @newsitems }
      end
    end
  end

  def features
    authorize! :features, Site.new

    @features = @site.features.page( params[:features_page] ).per( 9 )
  end

end
